import Client
import HostApp
import LaunchAgentManager
import SwiftUI
import XPCShared

@main
struct CopilotForXcodeApp: App {
    var body: some Scene {
        WindowGroup {
            TabContainer()
                .frame(minWidth: 800, minHeight: 600)
                .onAppear {
                    UserDefaults.setupDefaultSettings()
                }
        }
    }
}

var isPreview: Bool { ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" }

