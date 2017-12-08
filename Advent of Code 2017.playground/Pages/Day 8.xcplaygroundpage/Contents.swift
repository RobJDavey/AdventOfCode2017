//: [Previous](@previous) | [Contents](Contents)
/*:
 # Advent of Code 2017
 ## Day 8: I Heard You Like Registers
 
 You receive a signal directly from the CPU. Because of your recent assistance with [jump instructions](https://adventofcode.com/2017/day/5), it would like you to compute the result of a series of unusual register instructions.
 
 Each instruction consists of several parts: the register to modify, whether to increase or decrease that register's value, the amount by which to increase or decrease it, and a condition. If the condition fails, skip the instruction without modifying the register. The registers all start at 0. The instructions look like this:
 
 ```
 b inc 5 if a > 1
 a inc 1 if b < 5
 c dec -10 if a >= 1
 c inc -20 if c == 10
 ```
 
 These instructions would be processed as follows:
 
 * Because a starts at `0`, it is not greater than `1`, and so `b` is not modified.
 * `a` is increased by `1` (to `1`) because `b` is less than `5` (it is `0`).
 * `c` is decreased by `-10` (to `10`) because `a` is now greater than or equal to `1` (it is `1`).
 * `c` is increased by `-20` (to `-10`) because `c` is equal to `10`.
 
 After this process, the largest value in any register is `1`.
 
 You might also encounter `<=` (less than or equal to) or `!=` (not equal to). However, the CPU doesn't have the bandwidth to tell you what all the registers are named, and leaves that to you to determine.
 
 **What is the largest value in any register** after completing the instructions in your puzzle input?
 */
struct Instructions {
    private enum Modification: String {
        case incrememt = "inc"
        case decrement = "dec"
        
        func perform(current: Int, amount: Int) -> Int {
            switch self {
            case .decrement:
                return current - amount
            case .incrememt:
                return current + amount
            }
        }
    }
    
    private enum Operator: String {
        case greaterThan = ">"
        case lessThan = "<"
        case greaterThanOrEqual = ">="
        case lessThanOrEqual = "<="
        case equal = "=="
        case notEqual = "!="
        
        func calculate(lhs: Int, rhs: Int) -> Bool {
            switch self {
            case .equal:
                return lhs == rhs
            case .greaterThan:
                return lhs > rhs
            case .greaterThanOrEqual:
                return lhs >= rhs
            case .lessThan:
                return lhs < rhs
            case .lessThanOrEqual:
                return lhs <= rhs
            case .notEqual:
                return lhs != rhs
            }
        }
    }
    
    private struct Instruction {
        let register: String
        let modification: Modification
        let value: Int
        let leftHandSide: String
        let op: Operator
        let rightHandSide: Int
        
        init?(text: String) {
            let components = text.trimmingCharacters(in: .newlines).components(separatedBy: .whitespaces)
            guard components.count == 7 else {
                return nil
            }
            
            register = components[0]
            let modificationText = components[1]
            let valueText = components[2]
            let ifText = components[3]
            leftHandSide = components[4]
            let operatorText = components[5]
            let rightHandSideText = components[6]
            
            guard let modification = Modification(rawValue: modificationText),
                let value = Int(valueText),
                let op = Operator(rawValue: operatorText),
                let rightHandSide = Int(rightHandSideText),
                ifText == "if" else {
                    return nil
            }
            
            self.modification = modification
            self.value = value
            self.op = op
            self.rightHandSide = rightHandSide
        }
        
        func perform(on registers: inout [String: Int]) {
            let lhs = registers[leftHandSide, default: 0]
            let result = op.calculate(lhs: lhs, rhs: rightHandSide)
            
            guard result else {
                return
            }
            
            let current = registers[register, default: 0]
            let registerValue = modification.perform(current: current, amount: value)
            registers[register] = registerValue
        }
    }
    
    private let instructions: [Instruction]
    
    init?(input: String) {
        let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        instructions = lines.flatMap(Instruction.init)
        guard lines.count == instructions.count else {
            return nil
        }
    }
    
    func process() -> (max: Int, peak: Int) {
        var registers: [String: Int] = [:]
        var peak = 0
        var currentMax = 0
        
        instructions.forEach { instruction in
            instruction.perform(on: &registers)
            currentMax = registers.values.max() ?? 0
            peak = max(currentMax, peak)
        }
        
        return (currentMax, peak)
    }
}

let example = """
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
"""

guard let exampleInstruction = Instructions(input: example) else {
    fatalError()
}

let exampleResult = exampleInstruction.process()
let example1 = exampleResult.max
assert(example1 == 1)

let input = loadInput()

guard let instructions = Instructions(input: input) else {
    fatalError()
}

let result = instructions.process()

let answer1 = result.max
print("Part 1: \(answer1)")
/*:
 ## Part Two
 
 To be safe, the CPU also needs to know **the highest value held in any register during this process** so that it can decide how much memory to allocate to these operations. For example, in the above instructions, the highest value ever held was `10` (in register `c` after the third instruction was evaluated).
 */
let example2 = exampleResult.peak
assert(example2 == 10)

let answer2 = result.peak
print("Part 2: \(answer2)")
//: [Previous](@previous) | [Contents](Contents)
