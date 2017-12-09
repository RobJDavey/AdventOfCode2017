import Foundation

public func process(_ text: String) -> StreamItem {
    func processGarbage(_ text: String, index: inout String.Index) -> StreamItem {
        var ignoreNext = false
        var contents = ""
        
        while index < text.endIndex {
            let character = text[index]
            index = text.index(after: index)
            
            switch character {
            case _ where ignoreNext:
                ignoreNext = false
            case "!":
                ignoreNext = true
            case ">":
                return .garbage(contents)
            default:
                contents.append(character)
            }
        }
        
        fatalError("Garbage was never terminated")
    }
    
    func processGroup(_ text: String, index: inout String.Index) -> StreamItem {
        var groupItems: [StreamItem] = []
        
        while index < text.endIndex {
            let character = text[index]
            index = text.index(after: index)
            
            switch character {
            case "<":
                let garbage = processGarbage(text, index: &index)
                groupItems.append(garbage)
            case "{":
                let result = processGroup(text, index: &index)
                groupItems.append(result)
            case "}":
                return .group(groupItems)
            case ",":
                break
            default:
                fatalError("Unexpected character in group")
            }
        }
        
        fatalError("Group was never terminated")
    }
    
    var index = text.startIndex
    let first = text[index]
    
    guard first == "{" else {
        fatalError("Stream did not start with a '{' character")
    }
    
    index = text.index(after: index)
    return processGroup(text, index: &index)
}
