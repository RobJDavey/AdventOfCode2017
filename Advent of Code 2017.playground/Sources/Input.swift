import Foundation

public func loadInput() -> String {
    guard let inputURL = Bundle.main.url(forResource: "input", withExtension: nil),
        let inputData = try? Data(contentsOf: inputURL),
        let inputText = String(data: inputData, encoding: .utf8) else {
            fatalError("Could not load the input data")
    }

    return inputText.trimmingCharacters(in: .newlines)
}
