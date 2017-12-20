import Foundation

public func runPart1(particles: [Particle]) -> Int {
    var particles = particles
    var answer1: Int = 0
    
    for _ in 0..<1_000 {
        let new = particles.lazy.map { $0.update() }
        let distances = new.map { (particle: $0, distance: $0.p.distance(to: .origin) ) }
        let minDistance = distances.map { $0.distance }.min()!
        let minParticle = distances.filter { $0.distance == minDistance }.map { $0.particle }.first!
        answer1 = new.index(of: minParticle)!
        particles = Array(new)
    }
    
    return answer1
}

public func runPart2(particles: [Particle]) -> Int {
    var particles = particles
    
    for _ in 0..<40 {
        let new = particles.map { $0.update() }
        var counts: [Vector3 : Int] = [:]
        new.forEach { counts[$0.p, default: 0] += 1 }
        let duplicatePositions = counts.filter { (_, b) in b > 1 }.keys
        particles = new.filter { !duplicatePositions.contains($0.p) }
    }
    
    return particles.count
}
