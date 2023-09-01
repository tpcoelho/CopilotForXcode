import Foundation
import OpenAIService
import Parsing
import Preferences
import XcodeInspector

final class DynamicContextController {
    let memory: AutoManagedChatGPTMemory
    let functionProvider: ChatFunctionProvider

    init(
        memory: AutoManagedChatGPTMemory,
        functionProvider: ChatFunctionProvider
    ) {
        self.memory = memory
        self.functionProvider = functionProvider
    }

    func updatePromptToMatchContent(systemPrompt: String, content: String) async throws {
        var content = content
        let scopes = Self.parseScopes(&content)
        functionProvider.removeAll()
        let language = UserDefaults.shared.value(for: \.chatGPTLanguage)
        let oldMessages = await memory.history

        let contextualSystemPrompt = """
        \(language.isEmpty ? "" : "You must always reply in \(language)")
        \(systemPrompt)

        """
        await memory.mutateSystemPrompt(contextualSystemPrompt)
        functionProvider.append(functions: [])
    }
}

extension DynamicContextController {
    static func parseScopes(_ prompt: inout String) -> Set<String> {
        guard !prompt.isEmpty else { return [] }
        do {
            let parser = Parse {
                "@"
                Many {
                    Prefix { $0.isLetter }
                } separator: {
                    "+"
                } terminator: {
                    " "
                }
                Skip {
                    Many {
                        " "
                    }
                }
                Rest()
            }
            let (scopes, rest) = try parser.parse(prompt)
            prompt = String(rest)
            return Set(scopes.map(String.init))
        } catch {
            return []
        }
    }
}

