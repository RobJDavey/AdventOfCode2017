import Foundation

public typealias ValueType = Int64
public typealias Register = Character
public typealias Registers = [Register : ValueType]
public typealias Instructions = [Instruction]

public enum Instruction {
    case snd(Value)
    case set(Register, Value)
    case add(Register, Value)
    case mul(Register, Value)
    case mod(Register, Value)
    case rcv(Register)
    case jgz(Value, Value)
}

extension Instruction: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .snd(value):
            return "snd \(value)"
        case let .set(register, value):
            return "set \(register) \(value)"
        case let .add(register, value):
            return "add \(register) \(value)"
        case let .mul(register, value):
            return "mul \(register) \(value)"
        case let .mod(register, value):
            return "mod \(register) \(value)"
        case let .rcv(register):
            return "rcv \(register)"
        case let .jgz(register, value):
            return "jgz \(register) \(value)"
        }
    }
}

extension Instruction {
    public init?(_ string: String) {
        let components = string.components(separatedBy: .whitespaces)
        guard components.count > 1 else {
            return nil
        }
        
        switch components[0] {
        case "snd":
            guard let value = Value(components[1]) else {
                return nil
            }
            
            self = .snd(value)
        case "set":
            guard let (register, value) = Instruction.create(with: components) else {
                return nil
            }
            
            self = .set(register, value)
        case "add":
            guard let (register, value) = Instruction.create(with: components) else {
                return nil
            }
            
            self = .add(register, value)
        case "mul":
            guard let (register, value) = Instruction.create(with: components) else {
                return nil
            }
            
            self = .mul(register, value)
        case "mod":
            guard let (register, value) = Instruction.create(with: components) else {
                return nil
            }
            
            self = .mod(register, value)
        case "rcv":
            guard components.count == 2, components[1].count == 1 else {
                return nil
            }
            
            let register = Register(components[1])
            self = .rcv(register)
        case "jgz":
            guard components.count == 3,
                let x = Value(components[1]),
                let y = Value(components[2]) else {
                    return nil
            }
            
            self = .jgz(x, y)
        default:
            fatalError()
        }
    }
    
    private static func create(with components: [String]) -> (Register, Value)? {
        guard components.count == 3,
            components[1].count == 1,
            let value = Value(components[2]) else {
                return nil
        }
        
        let register = Register(components[1])
        return (register, value)
    }
}

extension Instruction {
    public func perform(on registers: inout Registers, index: inout Int) -> ValueType? {
        switch self {
        case .snd(_):
            fatalError()
        case let .set(register, value):
            perform(register: register, value: value, on: &registers) { $1 }
        case let .add(register, value):
            perform(register: register, value: value, on: &registers, operation: +)
        case let .mul(register, value):
            perform(register: register, value: value, on: &registers, operation: *)
        case let .mod(register, value):
            perform(register: register, value: value, on: &registers, operation: %)
        case .rcv(_):
            fatalError()
        case let .jgz(x, y):
            performJGZ(x, y, on: registers, index: &index)
        }
        
        index += 1
        return nil
    }
    
    private func perform(register: Register, value: Value, on registers: inout Registers, operation: (ValueType, ValueType) -> ValueType) {
        let lhs = registers[register, default: 0]
        let rhs = value.resolve(registers)
        let result = operation(lhs, rhs)
        registers[register] = result
    }
    
    private func performJGZ(_ x: Value, _ y: Value, on registers: Registers, index: inout Int) {
        let resolvedX = x.resolve(registers)
        if resolvedX > 0 {
            let resolvedY = y.resolve(registers)
            index += Int(resolvedY - 1)
        }
    }
}
