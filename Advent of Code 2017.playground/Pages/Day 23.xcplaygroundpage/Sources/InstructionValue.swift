import Foundation

public enum InstructionValue {
    case literal(LiteralType)
    case reference(Character)
}

extension InstructionValue: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .literal(literal):
            return String(literal)
        case let .reference(reference):
            return String(reference)
        }
    }
}

extension InstructionValue {
    init?(_ value: String) {
        if let literal = LiteralType(value) {
            self = .literal(literal)
        } else if value.count == 1 {
            self = .reference(Character(value))
        } else {
            return nil
        }
    }
    
    func resolve(on registers: Registers) -> LiteralType {
        switch self {
        case let .literal(literal):
            return literal
        case let .reference(reference):
            return registers[reference, default: 0]
        }
    }
}
