import Foundation

public struct Component {
    public let lhs: Port
    public let rhs: Port
}

extension Component: CustomStringConvertible {
    public var description: String {
        return "\(lhs)/\(rhs)"
    }
}

extension Component {
    public init?(_ string: String) {
        let components = string.components(separatedBy: "/")
        
        guard components.count == 2,
            let lhs = Port(components[0]),
            let rhs = Port(components[1]) else {
                return nil
        }
        
        self.lhs = lhs
        self.rhs = rhs
    }
    
    func canConnectTo(side: Port) -> Bool {
        return lhs == side || rhs == side
    }
    
    func otherPort(to port: Port) -> Port {
        return lhs == port ? rhs : lhs
    }
}
