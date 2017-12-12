import Foundation

public struct Program {
    public let pid: Int
    public let contacts: [Int]
    
    public init?(line: String) {
        let components = line.components(separatedBy: " <-> ")
        guard components.count == 2,
            let pid = Int(components[0]) else {
                return nil
        }
        
        let contactsText = components[1].components(separatedBy: ", ")
        let contacts = contactsText.flatMap(Int.init)
        guard contactsText.count == contacts.count else {
            return nil
        }
        
        self.pid = pid
        self.contacts = contacts
    }
}

extension Program: CustomStringConvertible {
    public var description: String {
        return "\(pid)"
    }
}

extension Program: Hashable {
    public var hashValue: Int {
        return pid.hashValue
    }
}

extension Program: Equatable {
    public static func ==(lhs: Program, rhs: Program) -> Bool {
        return lhs.pid == rhs.pid
    }
}
