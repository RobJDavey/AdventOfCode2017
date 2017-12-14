import Foundation

public typealias Firewall = [Int : FirewallLayer]

public func parseFirewall(text: String) -> Firewall {
    let lines = text.components(separatedBy: .newlines)
    let layers = lines.flatMap(FirewallLayer.init)
    var result: [Int : FirewallLayer] = [:]
    layers.forEach { result[$0.depth] = $0 }
    return result
}

public func calculateTotalSeverity(firewall: Firewall, delay: Int = 0) -> Int {
    func statusesForRoute() -> [Status] {
        let max = firewall.keys.max()!
        var statuses: [Status] = []
        
        for picoseconds in 0...max {
            let time = picoseconds + delay
            if let layer = firewall[picoseconds] {
                let status = layer.status(at: time)
                statuses.append(status)
            }
        }
        
        return statuses
    }
    
    let statuses = statusesForRoute()
    let totalSeverity = statuses.map { (status) -> Int in
        switch status {
        case let .caught(severity):
            return severity
        default:
            return 0
        }
        }.reduce(0, +)
    
    return totalSeverity
}

public func findSafeRoute(firewall: Firewall) -> Int {
    let maxDepth = firewall.keys.max()!
    
    func isRouteSafe(delay: Int = 0) -> Bool {
        for picoseconds in 0...maxDepth {
            let time = picoseconds + delay
            
            guard let layer = firewall[picoseconds] else {
                continue
            }
            
            guard case .safe = layer.status(at: time) else {
                return false
            }
        }
        
        return true
    }

    for delay in 0... {
        let safe = isRouteSafe(delay: delay)
        if safe {
            return delay
        }
    }
    
    fatalError()
}
