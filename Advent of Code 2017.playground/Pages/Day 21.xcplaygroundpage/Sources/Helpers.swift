import Foundation

public typealias Cell = Character
public typealias Row = [Cell]
public typealias Grid = [Row]
public typealias Map = [String : Grid]

public func count(grid: Grid) -> Int {
    var total = 0
    
    for y in 0..<grid.count {
        let row = grid[y]
        for x in 0..<row.count {
            let cell = row[x]
            if cell == "#" {
                total += 1
            }
        }
    }
    
    return total
}

public func enhance(grid: Grid, maps: Map) -> Grid {
    func split(grid: Grid, count: Int) -> [Grid] {
        var result: [Grid] = []
        
        for y in stride(from: 0, to: grid.count, by: count) {
            for x in stride(from: 0, to: grid.count, by: count) {
                var chunk: Grid = []
                
                for j in 0..<count {
                    var row: Row = []
                    
                    for i in 0..<count {
                        let dx = x + i
                        let dy = y + j
                        let element = grid[dy][dx]
                        row.append(element)
                    }
                    
                    chunk.append(row)
                }
                
                result.append(chunk)
            }
        }
        
        return result
    }
    
    func combineChunks(chunks: [Grid]) -> Grid {
        let chunkCount = chunks.count
        let chunkSize = chunks.first!.count
        let sideCount = Int(sqrt(Double(chunkCount)))
        let sideSize = chunkSize * sideCount
        var result = Array(repeating: Array(repeating: Character(" "), count: sideSize), count: sideSize)
        
        for chunkY in 0..<sideCount {
            for chunkX in 0..<sideCount {
                let offset = (chunkY * sideCount) + chunkX
                let chunk = chunks[offset]
                for y in 0..<chunkSize {
                    for x in 0..<chunkSize {
                        let cell = chunk[y][x]
                        result[(chunkY * chunkSize) + y][(chunkX * chunkSize) + x] = cell
                    }
                }
            }
        }
        
        return result
    }
    
    func enhanceChunk(_ chunk: Grid) -> Grid {
        let chunkKey = Pattern(pattern: chunk)
        let pattern = maps[chunkKey.description]!
        return pattern
    }
    
    let size = grid.count
    let chunks: [Grid]
    switch size {
    case 2, 3:
        return enhanceChunk(grid)
    case _ where size % 2 == 0:
        chunks = split(grid: grid, count: 2)
    case _ where size % 3 == 0:
        chunks = split(grid: grid, count: 3)
    default:
        fatalError()
    }
    
    let enhancedChunks = chunks.map { enhance(grid: $0, maps: maps) }
    return combineChunks(chunks: enhancedChunks)
}
