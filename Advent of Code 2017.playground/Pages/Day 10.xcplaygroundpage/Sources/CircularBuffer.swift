import Foundation

public struct CircularBuffer<T> {
    private var storage: [T]
    
    init(_ values: [T]) {
        storage = values
    }
    
    var buffer: [T] {
        return storage
    }
}

extension CircularBuffer: CustomStringConvertible {
    public var description: String {
        return storage.description
    }
}

extension CircularBuffer: Collection {
    public var startIndex: Int {
        return storage.startIndex
    }
    
    public var endIndex: Int {
        return Int.max
    }
    
    public func index(after i: Int) -> Int {
        return storage.index(after: i)
    }
    
    public subscript(index: Int) -> T {
        get {
            return storage[index % storage.count]
        }
        
        mutating set {
            storage[index % storage.count] = newValue
        }
    }
}
