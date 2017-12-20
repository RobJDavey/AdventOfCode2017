import Foundation

public struct Particle {
    public let p: Vector3
    public let v: Vector3
    public let a: Vector3
}

extension Particle: CustomStringConvertible {
    public var description: String {
        return "p=\(p), v=\(v), a=\(a)"
    }
}

extension Particle: Equatable {
    public static func ==(lhs: Particle, rhs: Particle) -> Bool {
        return lhs.p == rhs.p && lhs.v == rhs.v && lhs.a == rhs.a
    }
}

extension Particle: Hashable {
    public var hashValue: Int {
        return p.hashValue ^ v.hashValue ^ a.hashValue
    }
}

extension Particle {
    public init?(_ string: String) {
        let components = string.components(separatedBy: ", ")
        guard components.count == 3 else {
            return nil
        }
        
        let values = components.flatMap { component in
            guard let startMarker = component.index(of: "<"),
                let end = component.index(of: ">"),
                startMarker < end else {
                    return nil
            }
            
            let start = component.index(after: startMarker)
            return String(component[start..<end])
        }
        
        let vectors = values.flatMap(Vector3.init)
        guard vectors.count == 3 else {
            return nil
        }
        
        let p = vectors[0]
        let v = vectors[1]
        let a = vectors[2]
        self.init(p: p, v: v, a: a)
    }
    
    public func update() -> Particle {
        let newV = v + a
        let newP = p + newV
        return Particle(p: newP, v: newV, a: a)
    }
}
