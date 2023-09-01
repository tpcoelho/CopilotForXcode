import Combine
import Foundation
import SwiftUI

/// A chat tab that provides a context aware chat bot, powered by ChatGPT.
public class ChatGPTChatTab: ChatTab {
    public let provider: ChatProvider
    private var cancellable = Set<AnyCancellable>()

    public func buildView() -> any View {
        ChatPanel(chat: provider)
    }

    public init() {
        provider = .init()
        super.init(id: "Chat-" + provider.id.uuidString, title: "Chat")
        
        provider.$history.sink { [weak self] _ in
            if let title = self?.provider.title {
                self?.title = title
            }
        }.store(in: &cancellable)
    }
}
