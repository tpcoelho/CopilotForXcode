import Environment
import FileChangeChecker
import LaunchAgentManager
import Logger
import Preferences
import Service
import ServiceManagement
import ServiceUpdateMigration
import SwiftUI
import UserDefaultsObserver
import UserNotifications
import XcodeInspector

let bundleIdentifierBase = Bundle.main
    .object(forInfoDictionaryKey: "BUNDLE_IDENTIFIER_BASE") as! String
let serviceIdentifier = bundleIdentifierBase + ".ExtensionService"

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    let scheduledCleaner = ScheduledCleaner()
    var statusBarItem: NSStatusItem!
    var xpcListener: (NSXPCListener, ServiceDelegate)?

    func applicationDidFinishLaunching(_: Notification) {
        if ProcessInfo.processInfo.environment["IS_UNIT_TEST"] == "YES" { return }
        _ = GraphicalUserInterfaceController.shared
        _ = RealtimeSuggestionController.shared
        _ = XcodeInspector.shared
        AXIsProcessTrustedWithOptions([
            kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true,
        ] as CFDictionary)
        setupQuitOnUpdate()
        setupQuitOnUserTerminated()
        xpcListener = setupXPCListener()
        Logger.service.info("XPC Service started.")
        NSApp.setActivationPolicy(.accessory)
        buildStatusBarMenu()
        DependencyUpdater().update()

        Task {
            do {
                try await ServiceUpdateMigrator().migrate()
            } catch {
                Logger.service.error(error.localizedDescription)
            }
        }
    }

    @objc func quit() {
        Task { @MainActor in
            await scheduledCleaner.closeAllChildProcesses()
            exit(0)
        }
    }

    @objc func openCopilotForXcode() {
        let task = Process()
        if let appPath = locateHostBundleURL(url: Bundle.main.bundleURL)?.absoluteString {
            task.launchPath = "/usr/bin/open"
            task.arguments = [appPath]
            task.launch()
            task.waitUntilExit()
        }
    }

    @objc func openGlobalChat() {
        Task { @MainActor in
            let serviceGUI = GraphicalUserInterfaceController.shared
            serviceGUI.openGlobalChat()
        }
    }

    func setupQuitOnUpdate() {
        Task {
            guard let url = Bundle.main.executableURL else { return }
            let checker = await FileChangeChecker(fileURL: url)

            // If Xcode or Copilot for Xcode is made active, check if the executable of this program
            // is changed. If changed, quit this program.

            let sequence = NSWorkspace.shared.notificationCenter
                .notifications(named: NSWorkspace.didActivateApplicationNotification)
            for await notification in sequence {
                try Task.checkCancellation()
                guard let app = notification
                    .userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
                    app.isUserOfService
                else { continue }
                guard await checker.checkIfChanged() else {
                    Logger.service.info("Extension Service is not updated, no need to quit.")
                    continue
                }
                Logger.service.info("Extension Service will quit.")
                #if DEBUG
                #else
                quit()
                #endif
            }
        }
    }

    func setupQuitOnUserTerminated() {
        Task {
            // Whenever Xcode or the host application quits, check if any of the two is running.
            // If none, quit the XPC service.

            let sequence = NSWorkspace.shared.notificationCenter
                .notifications(named: NSWorkspace.didTerminateApplicationNotification)
            for await notification in sequence {
                try Task.checkCancellation()
                guard UserDefaults.shared.value(for: \.quitXPCServiceOnXcodeAndAppQuit)
                else { continue }
                guard let app = notification
                    .userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
                    app.isUserOfService
                else { continue }
                if NSWorkspace.shared.runningApplications.contains(where: \.isUserOfService) {
                    continue
                }
                quit()
            }
        }
    }

    func setupXPCListener() -> (NSXPCListener, ServiceDelegate) {
        let listener = NSXPCListener(machServiceName: serviceIdentifier)
        let delegate = ServiceDelegate()
        listener.delegate = delegate
        listener.resume()
        return (listener, delegate)
    }

    func requestAccessoryAPIPermission() {
        AXIsProcessTrustedWithOptions([
            kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true,
        ] as NSDictionary)
    }
}

extension NSRunningApplication {
    var isUserOfService: Bool {
        [
            "com.apple.dt.Xcode",
            bundleIdentifierBase,
        ].contains(bundleIdentifier)
    }
}

func locateHostBundleURL(url: URL) -> URL? {
    var nextURL = url
    while nextURL.path != "/" {
        nextURL = nextURL.deletingLastPathComponent()
        if nextURL.lastPathComponent.hasSuffix(".app") {
            return nextURL
        }
    }
    let devAppURL = url
        .deletingLastPathComponent()
        .appendingPathComponent("Copilot for Xcode Dev.app")
    return devAppURL
}

