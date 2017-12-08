import Foundation

public typealias ReallocationResult = (initialIndex: Int, repeatedIndex: Int)

public func performReallocation(memoryBanks: [Int]) -> ReallocationResult {
    var memoryBanks = memoryBanks
    var cache: [[Int]] = []
    let count = memoryBanks.count - 1
    
    repeat {
        guard count > 1,
            let max = memoryBanks.max(),
            let index = memoryBanks.index(of: max) else {
                fatalError()
        }
        
        cache.append(memoryBanks)
        var value = memoryBanks[index]
        
        for i in index + 1..<index + memoryBanks.count where value != 0 {
            let wrappedIndex = i % memoryBanks.count
            if wrappedIndex == index {
                break
            }
            
            memoryBanks[wrappedIndex] += 1
            value -= 1
        }
        
        memoryBanks[index] = value
    } while !cache.contains { $0 == memoryBanks }
    
    guard let cacheIndex = cache.index(where: { $0 == memoryBanks }) else {
        fatalError()
    }
    
    return (cacheIndex, cache.count)
}
