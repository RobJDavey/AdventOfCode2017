import Foundation

public final class Program {
    let queue: DispatchQueue
    let semaphore: DispatchSemaphore
    
    public var sends = 0
    var registers: Registers
    var inbox: [ValueType] = []
    var index: Int = 0
    
    public init(_ pid: ValueType) {
        queue = DispatchQueue(label: "program-\(pid)")
        semaphore = DispatchSemaphore(value: 0)
        registers = ["p" : pid]
    }
    
    public func run(instructions: Instructions, other: Program) {
        repeat {
            let instruction = instructions[index]
            switch instruction {
            case let .snd(x):
                index += 1
                let value = x.resolve(registers)
                send(to: other, value: value)
            case let .rcv(x):
                guard let value = receive() else {
                    return
                }
                
                index += 1
                registers[x] = value
            default:
                _ = instruction.perform(on: &registers, index: &index)
            }
        } while index >= 0 && index < instructions.count
    }
    
    func send(to program: Program, value: ValueType) {
        sends += 1
        program.addValue(value: value)
    }
    
    func receive() -> ValueType? {
        let uptimeNanoseconds =  DispatchTime.now().uptimeNanoseconds + (NSEC_PER_SEC * 1)
        let time = DispatchTime(uptimeNanoseconds: uptimeNanoseconds)
        let result = semaphore.wait(timeout: time)
        guard result == .success else {
            return nil
        }
        
        var value: ValueType?
        queue.sync {
            value = inbox.removeFirst()
        }
        return value
    }
    
    func addValue(value: ValueType) {
        queue.sync {
            inbox.append(value)
            semaphore.signal()
        }
    }
}
