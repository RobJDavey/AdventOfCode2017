import Foundation

public func countJumpsToExit(input: [Int], updateValue: (Int) -> Int) -> Int {
    var values = input
    var index = 0
    var count = 0
    
    repeat {
        let value = values[index]
        let newIndex = values.index(index, offsetBy: value)
        values[index] = updateValue(value)
        index = newIndex
        count += 1
    } while index < values.count
    
    return count
}

public func part1Updater(value: Int) -> Int {
    return value + 1
}

public func part2Updater(value: Int) -> Int {
    return value >= 3 ? value - 1 : value + 1
}
