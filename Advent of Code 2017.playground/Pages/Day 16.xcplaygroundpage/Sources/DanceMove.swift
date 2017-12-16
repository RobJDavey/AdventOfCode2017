import Foundation

public enum DanceMove {
    case spin(Int)
    case exchange(Int, Int)
    case partner(Character, Character)
}

extension DanceMove {
    public init?(_ string: String) {
        let suffix = string.dropFirst()
        
        switch string.prefix(1) {
        case "s":
            let number = Int(suffix)!
            self = .spin(number)
        case "x":
            let components = suffix.components(separatedBy: "/")
            let i = Int(components[0])!
            let j = Int(components[1])!
            self = .exchange(i, j)
        case "p":
            let components = suffix.components(separatedBy: "/")
            let a = Character(components[0])
            let b = Character(components[1])
            self = .partner(a, b)
        default:
            return nil
        }
    }
    
    public func dance(with programs: [Character]) -> [Character] {
        switch self {
        case let .spin(x):
            return spinPrograms(programs, by: x)
        case let .exchange(i, j):
            return exchangePrograms(programs, i: i, j: j)
        case let .partner(a, b):
            return partnerPrograms(programs, a: a, b: b)
        }
    }
    
    func spinPrograms(_ programs: [Character], by x: Int) -> [Character] {
        let end = programs.suffix(x)
        let others = programs.dropLast(x)
        return Array(end + others)
    }
    
    func exchangePrograms(_ programs: [Character], i: Int, j: Int) -> [Character] {
        var programs = programs
        (programs[i], programs[j]) = (programs[j], programs[i])
        return programs
    }
    
    func partnerPrograms(_ programs: [Character], a: Character, b: Character) -> [Character] {
        let i = programs.index(of: a)!
        let j = programs.index(of: b)!
        return exchangePrograms(programs, i: i, j: j)
    }
}
