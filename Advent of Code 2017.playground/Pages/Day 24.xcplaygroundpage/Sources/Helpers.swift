import Foundation

public typealias Bridge = [Component]
public typealias BridgeSelector = (Bridge, Bridge) -> Bridge
public typealias Components = [Component]
public typealias Port = Int
public typealias Score = Int

public func part1Selector(lhs: Bridge, rhs: Bridge) -> Bridge {
    let lhsScore = score(for: lhs)
    let rhsScore = score(for: rhs)
    return lhsScore >= rhsScore ? lhs : rhs
}

public func part2Selector(lhs: Bridge, rhs: Bridge) -> Bridge {
    if lhs.count != rhs.count {
        return lhs.count > rhs.count ? lhs : rhs
    }
    
    return part1Selector(lhs: lhs, rhs: rhs)
}

public func createBridge(with components: Components, selector: BridgeSelector, previous: Port = 0) -> Bridge {
    var bridge: [Component] = []
    
    for (index, component) in components.enumerated() where component.canConnectTo(side: previous) {
        let other = component.otherPort(to: previous)
        var remaining = components
        remaining.remove(at: index)
        
        let newBridge = [component] + createBridge(with: remaining, selector: selector, previous: other)
        bridge = selector(bridge, newBridge)
    }
    
    return bridge
}

public func score(for bridge: Bridge) -> Score {
    return bridge.reduce(0) { prev, current in prev + current.lhs + current.rhs }
}
