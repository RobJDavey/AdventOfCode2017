import Foundation

public struct Vector3 {
    let x: Int
    let y: Int
    let z: Int
}

extension Vector3: CustomStringConvertible {
    public var description: String {
        return "<\(x),\(y),\(z)>"
    }
}

extension Vector3: Equatable {
    public static func ==(lhs: Vector3, rhs: Vector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

extension Vector3: Hashable {
    public var hashValue: Int {
        return x.hashValue ^ y.hashValue ^ z.hashValue
    }
}

extension Vector3 {
    public static let origin = Vector3(x: 0, y: 0, z: 0)
    
    init?(_ string: String) {
        let components = string.components(separatedBy: ",")
        guard components.count == 3,
            let x = Int(components[0]),
            let y = Int(components[1]),
            let z = Int(components[2]) else {
                return nil
        }
        
        self.init(x: x, y: y, z: z)
    }
    
    public func distance(to other: Vector3) -> Int {
        let dX = abs(other.x - x)
        let dY = abs(other.y - y)
        let dZ = abs(other.z - z)
        return dX + dY + dZ
    }
    
    static func +(lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
}
