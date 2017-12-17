import Foundation

public func solvePart1(iterations: Int, step: Int) -> Int {
    var buffer = [0]
    var index = buffer.startIndex
    
    for iteration in 1...iterations {
        index = (index + step) % iteration + 1
        buffer.insert(iteration, at: index)
    }
    
    index = (index + 1) % iterations
    return buffer[index]
}

public func solvePart2(iterations: Int, step: Int) -> Int {
    var index = 0
    var result = 0
    
    for iteration in 1...iterations + 1 {
        index = (index + step) % iteration + 1
        if index == 1 {
            result = iteration
        }
    }
    
    return result
}
