import Foundation

public struct Pattern {
    let pattern: [[Cell]]
}

extension Pattern {
    public init(string: String) {
        pattern = string.components(separatedBy: "/").map { s in Array(s) }
    }
    
    public func rotated() -> Pattern {
        let count = pattern.count
        var result = Array(repeating: Array(repeating: Character(" "), count: count), count: count)
        
        for y in 0..<count {
            for x in 0..<count {
                result[y][x] = pattern[count - x - 1][y]
            }
        }
        
        return Pattern(pattern: result)
    }
    
    public func flipped() -> Pattern {
        let count = pattern.count
        var result = Array(repeating: Array(repeating: Character(" "), count: count), count: count)
        
        for y in 0..<count {
            for x in 0..<count {
                result[y][x] = pattern[y][count - x - 1]
            }
        }
        
        return Pattern(pattern: result)
    }
}

extension Pattern: CustomStringConvertible {
    public var description: String {
        return pattern.map { String($0) }.joined(separator: "/")
    }
}
