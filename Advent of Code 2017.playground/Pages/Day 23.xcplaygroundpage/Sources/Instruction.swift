import Foundation

public enum Instruction {
    case set(RegisterType, InstructionValue)
    case sub(RegisterType, InstructionValue)
    case mul(RegisterType, InstructionValue)
    case jnz(InstructionValue, InstructionValue)
}

extension Instruction: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .set(x, y):
            return "set \(x) \(y)"
        case let .sub(x, y):
            return "sub \(x) \(y)"
        case let .mul(x, y):
            return "mul \(x) \(y)"
        case let .jnz(x, y):
            return "jnz \(x) \(y)"
        }
    }
}

extension Instruction {
    public init?(_ value: String) {
        let parts = value.components(separatedBy: .whitespaces)
        guard parts.count == 3, let y = InstructionValue(parts[2]) else {
            return nil
        }
        
        switch parts[0] {
        case "set":
            guard parts[1].count == 1 else {
                return nil
            }
            let x = Character(parts[1])
            self = .set(x, y)
        case "sub":
            guard parts[1].count == 1 else {
                return nil
            }
            let x = Character(parts[1])
            self = .sub(x, y)
        case "mul":
            guard parts[1].count == 1 else {
                return nil
            }
            let x = Character(parts[1])
            self = .mul(x, y)
        case "jnz":
            guard let x = InstructionValue(parts[1]) else {
                return nil
            }
            self = .jnz(x, y)
        default:
            return nil
        }
    }
    
    public func execute(on registers: inout Registers, index: inout Int) {
        switch self {
        case let .set(x, y):
            registers[x] = y.resolve(on: registers)
        case let .sub(x, y):
            registers[x, default: 0] -= y.resolve(on: registers)
        case let .mul(x, y):
            registers[x, default: 0] *= y.resolve(on: registers)
        case let .jnz(x, y):
            let x = x.resolve(on: registers)
            if x != 0 {
                index += y.resolve(on: registers)
                return
            }
        }
        
        index += 1
    }
}
