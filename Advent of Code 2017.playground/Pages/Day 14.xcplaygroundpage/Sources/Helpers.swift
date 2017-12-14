import Foundation

typealias Point = (x: Int, y: Int)

let offsets: [Point] = [(x: 0, y: 1), (x: 1, y: 0), (x: 0, y: -1), (x: -1, y: 0)]

public func countRegions(in disk: [[Bool]]) -> Int {
    func clearRegion(in disk: inout [[Bool]], x: Int, y: Int) {
        guard x >= 0 && x < 128 && y >= 0 && y < 128 else {
            return
        }
        
        let current = disk[x][y]
        
        guard current else {
            return
        }
        
        disk[x][y] = false
        
        for offset in offsets {
            clearRegion(in: &disk, x: x + offset.x, y: y + offset.y)
        }
    }
    
    var disk = disk
    var count = 0
    
    for y in 0..<128 {
        for x in 0..<128 {
            let value = disk[x][y]
            
            guard value else {
                continue
            }
            
            clearRegion(in: &disk, x: x, y: y)
            count += 1
        }
    }
    
    return count
}
