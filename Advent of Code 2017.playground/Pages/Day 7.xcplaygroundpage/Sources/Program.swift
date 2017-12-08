import Foundation

public final class Program {
    public let name: String
    public let weight: Int
    public let children: [Program]
    public weak var parent: Program?
    
    init(name: String, weight: Int, children: [Program]) {
        self.name = name
        self.weight = weight
        self.children = children
        children.forEach { $0.parent = self }
    }
    
    public var towerWeight: Int {
        let childWeights = children.map { $0.towerWeight }
        return weight + childWeights.reduce(0, +)
    }
}

extension Program: CustomStringConvertible {
    public var description: String {
        return "\(name) (\(weight))"
    }
}
