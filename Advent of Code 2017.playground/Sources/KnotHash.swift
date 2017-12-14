import Foundation

public typealias Buffer = [UInt8]

private let knotHashBlockSize = 16

public func knotHashRound(values: Buffer, lengths: [Int], index: inout Int, skip: inout Int) -> Buffer {
    var list = CircularBuffer(values)
    
    for length in lengths {
        let endIndex = index.advanced(by: length)
        let range = index..<endIndex
        let values = list[range]
        let reverse = values.reversed()
        let indexes = zip(range, 0..<length)
        
        for (listIndex, reverseIndex) in indexes {
            list[listIndex] = reverse[reverseIndex]
        }
        
        index = endIndex.advanced(by: skip)
        skip += 1
    }
    
    return list.buffer
}

public func knotHash(_ input: String) -> String {
    let denseHash: Buffer = knotHash(input)
    let denseHashComponents = denseHash.map { String(format: "%02x", $0) }
    return denseHashComponents.joined()
}

public func knotHash(_ input: String) -> Buffer {
    func reduceHash(sparseHash: Buffer) -> Buffer {
        precondition(sparseHash.count % knotHashBlockSize == 0)
        var denseHash: Buffer = []
        var blockStartIndex = sparseHash.startIndex
        
        repeat {
            let blockEndIndex = blockStartIndex.advanced(by: knotHashBlockSize)
            let block = sparseHash[blockStartIndex..<blockEndIndex]
            let denseHashByte = block.reduce(0, ^)
            denseHash.append(denseHashByte)
            blockStartIndex = blockEndIndex
        } while blockStartIndex < sparseHash.endIndex
        
        return denseHash
    }
    
    
    var values: Buffer = Array(UInt8.min...UInt8.max)
    assert(values.count % knotHashBlockSize == 0)
    let lengths = Array(input.utf8.map(Int.init)) + [17, 31, 73, 47, 23]
    var index = values.startIndex
    var skip = 0
    
    for _ in 0..<64 {
        values = knotHashRound(values: values, lengths: lengths, index: &index, skip: &skip)
    }
    
    return reduceHash(sparseHash: values)
}
