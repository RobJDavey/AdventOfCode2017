import Foundation

enum Movement: String {
    case left, right
}

extension Movement {
    func move(cursor: Int, tape: [Int]) -> (cursor: Int, tape: [Int]) {
        var cursor = cursor
        var tape = tape
        move(cursor: &cursor, tape: &tape)
        return (cursor, tape)
    }
    
    func move(cursor: inout Int, tape: inout [Int]) {
        switch self {
        case .left:
            cursor -= 1
            if cursor < tape.startIndex {
                cursor = 0
                tape.insert(0, at: cursor)
            }
        case .right:
            cursor += 1
            if cursor >= tape.endIndex {
                cursor = tape.endIndex
                tape.append(0)
            }
        }
    }
}
