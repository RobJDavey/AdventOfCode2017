import Foundation

public typealias LiteralType = Int
public typealias RegisterType = Character
public typealias Registers = [RegisterType : LiteralType]

public func runPart1(instructions: [Instruction]) -> Int {
    var registers: Registers = [:]
    var index = 0
    var history: [Instruction] = []
    
    repeat {
        let instruction = instructions[index]
        history.append(instruction)
        instruction.execute(on: &registers, index: &index)
    } while index >= 0 && index < instructions.count
    
    var count = 0
    
    for instruction in history {
        if case .mul(_, _) = instruction {
            count += 1
        }
    }
    
    return count
}

public func runPart2() -> Int {
    var h = 0
    
    for b in stride(from: 105700, through: 122700, by: 17) {
        for d in 2..<b {
            if b % d == 0 {
                h += 1
                break
            }
        }
    }
    
    return h
}
