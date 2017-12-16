import Foundation

public typealias DanceMoves = [DanceMove]

public func perform(danceMoves: DanceMoves, programs: String = "abcdefghijklmnop", iterations: Int = 1) -> String {
    func dance(danceMoves: DanceMoves, programs: [Character]) -> [Character] {
        var current = programs
        
        for danceMove in danceMoves {
            current = danceMove.dance(with: current)
        }
        
        return current
    }
    
    var current = Array(programs)
    var cache = [current]
    
    for _ in 0..<iterations {
        current = dance(danceMoves: danceMoves, programs: current)
        
        if cache.contains(where: { $0 == current }) {
            return String(cache[iterations % cache.count])
        } else {
            cache.append(current)
        }
    }
    
    return String(current)
}
