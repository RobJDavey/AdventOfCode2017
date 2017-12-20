import Foundation

public enum Value {
    case register(Register)
    case number(ValueType)
}

extension Value: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .number(value):
            return String(value)
        case let .register(register):
            return String(register)
        }
    }
}

extension Value {
    public init?(_ string: String) {
        if let value = ValueType(string) {
            self = .number(value)
        } else if string.count == 1 {
            self = .register(string.first!)
        } else {
            return nil
        }
    }
}

extension Value {
    public func resolve(_ registers: Registers) -> ValueType {
        switch self {
        case let .register(register):
            return registers[register, default: 0]
        case let .number(value):
            return value
        }
    }
}
