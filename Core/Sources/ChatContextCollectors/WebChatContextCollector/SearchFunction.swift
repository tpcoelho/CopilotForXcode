import Foundation
import OpenAIService
import Preferences

struct SearchFunction: ChatGPTFunction {
    func call(arguments: Arguments) async throws -> Result {
        return Result()
    }

    static let dateFormatter = {
        let it = DateFormatter()
        it.dateFormat = "yyyy-MM-dd"
        return it
    }()

    struct Arguments: Codable {
        var query: String
        var freshness: String?
    }

    struct Result: ChatGPTFunctionResult {

        var botReadableContent: String {
            return ""
        }
    }

    var reportProgress: (String) async -> Void = { _ in }

    var name: String {
        "searchWeb"
    }

    var description: String {
        "Useful for when you need to answer questions about latest information."
    }

    var argumentSchema: JSONSchemaValue {
        let today = Self.dateFormatter.string(from: Date())
        return [
            .type: "object",
            .properties: [
                "query": [
                    .type: "string",
                    .description: "the search query",
                ],
                "freshness": [
                    .type: "string",
                    .description: .string(
                        "limit the search result to a specific range, use only when user ask the question about current events. Today is \(today). Format: yyyy-MM-dd..yyyy-MM-dd"
                    ),
                    .examples: ["1919-10-20..1988-10-20"],
                ],
            ],
            .required: ["query"],
        ]
    }

    func prepare() async {
        await reportProgress("Searching..")
    }
}

