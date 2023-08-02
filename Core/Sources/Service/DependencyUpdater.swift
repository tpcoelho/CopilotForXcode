import GitHubCopilotService
import Logger

public struct DependencyUpdater {
    public init() {}

    public func update() {
        Task {
            await withTaskGroup(of: Void.self) { taskGroup in
                let gitHubCopilot = GitHubCopilotInstallationManager()
                switch gitHubCopilot.checkInstallation() {
                case .notInstalled: break
                case .installed: break
                case .unsupported: break
                case .outdated:
                    taskGroup.addTask {
                        do {
                            for try await step in gitHubCopilot.installLatestVersion() {
                                let state = {
                                    switch step {
                                    case .downloading:
                                        return "Downloading"
                                    case .uninstalling:
                                        return "Uninstalling old version"
                                    case .decompressing:
                                        return "Decompressing"
                                    case .done:
                                        return "Done"
                                    }
                                }()
                                Logger.service
                                    .error("Update GitHub Copilot language server: \(state)")
                            }
                        } catch {
                            Logger.service.error(
                                "Update GitHub Copilot language server: \(error.localizedDescription)"
                            )
                        }
                    }
                }
            }
        }
    }
}

