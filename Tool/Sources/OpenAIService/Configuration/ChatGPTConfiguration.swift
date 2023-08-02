import Foundation
import Preferences

public protocol ChatGPTConfiguration {
    var featureProvider: ChatFeatureProvider { get }
    var temperature: Double { get }
    var model: String { get }
    var endpoint: String { get }
    var apiKey: String { get }
    var stop: [String] { get }
    var maxTokens: Int { get }
    var minimumReplyTokens: Int { get }
    var runFunctionsAutomatically: Bool { get }
}

public extension ChatGPTConfiguration {
    func endpoint(for provider: ChatFeatureProvider) -> String {
        switch provider {
        case .openAI:
            let baseURL = UserDefaults.shared.value(for: \.openAIBaseURL)
            if baseURL.isEmpty { return "https://api.openai.com/v1/chat/completions" }
            return "\(baseURL)/v1/chat/completions"
        }
    }

    func apiKey(for provider: ChatFeatureProvider) -> String {
        switch provider {
        case .openAI:
            return UserDefaults.shared.value(for: \.openAIAPIKey)
        }
    }

    func overriding(
        _ overrides: OverridingChatGPTConfiguration<Self>.Overriding
    ) -> OverridingChatGPTConfiguration<Self> {
        .init(overriding: self, with: overrides)
    }

    func overriding(
        _ update: (inout OverridingChatGPTConfiguration<Self>.Overriding) -> Void = { _ in }
    ) -> OverridingChatGPTConfiguration<Self> {
        var overrides = OverridingChatGPTConfiguration<Self>.Overriding()
        update(&overrides)
        return .init(overriding: self, with: overrides)
    }
}

