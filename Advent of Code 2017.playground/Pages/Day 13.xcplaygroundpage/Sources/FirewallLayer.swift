import Foundation

public struct FirewallLayer {
    let depth: Int
    let range: Int
    
    public init?(firewallLine: String) {
        let parts = firewallLine.components(separatedBy: ": ")
        
        guard parts.count == 2,
            let depthText = parts.first,
            let depth = Int(depthText),
            let rangeText = parts.last,
            let range = Int(rangeText) else {
            return nil
        }
        
        self.depth = depth
        self.range = range
    }
}

extension FirewallLayer {
    func position(at picoseconds: Int) -> Int {
        let cycleCount = (range - 1) * 2
        let cyclePosition = picoseconds % cycleCount
        return cyclePosition
    }
    
    func status(at picoseconds: Int) -> Status {
        let pos = position(at: picoseconds)
        switch pos {
        case 0:
            return .caught(severity: depth * range)
        default:
            return .safe
        }
    }
}
