//: [Previous](@previous) | [Contents](Contents)
/*:
 # Advent of Code 2017
 ## Day 11: Hex Ed
 
 Crossing the bridge, you've barely reached the other side of the stream when a program comes up to you, clearly in distress. "It's my child process," she says, "he's gotten lost in an infinite grid!"
 
 Fortunately for her, you have plenty of experience with infinite grids.
 
 Unfortunately for you, it's a [hex grid](https://en.wikipedia.org/wiki/Hexagonal_tiling).
 
 The hexagons ("hexes") in this grid are aligned such that adjacent hexes can be found to the north, northeast, southeast, south, southwest, and northwest:
 
 ```
   \ n  /
 nw +--+ ne
   /    \
 -+      +-
   \    /
 sw +--+ se
   / s  \
 ```
 
 You have the path the child process took. Starting where he started, you need to determine the fewest number of steps required to reach him. (A "step" means to move from the hex you are in to any adjacent hex.)
 
 For example:
 
 * `ne,ne,ne` is `3` steps away.
 * `ne,ne,sw,sw` is `0` steps away (back where you started).
 * `ne,ne,s,s` is `2` steps away (`se,se`).
 * `se,sw,se,sw,sw` is `3` steps away (`s,s,sw`).
 
 */
func finalDistance(directions: [Direction]) -> Int {
    let point: Point = Point.origin.follow(directions: directions)
    return point.distance(to: .origin)
}

func test(directions: [Direction], expected: Int) {
    let actual = finalDistance(directions: directions)
    assert(actual == expected)
}

test(directions: [.northEast, .northEast, .northEast], expected: 3)
test(directions: [.northEast, .northEast, .southWest, .southWest], expected: 0)
test(directions: [.northEast, .northEast, .south, .south], expected: 2)
test(directions: [.southEast, .southWest, .southEast, .southWest, .southWest], expected: 3)

let input = loadInput()
let components = input.components(separatedBy: ",")
let directions = components.flatMap(Direction.init)

assert(components.count == directions.count)
let answer1 = finalDistance(directions: directions)
print("Part 1: \(answer1)")
/*:
 ## Part 2
 
 **How many steps away** is the **furthest** he ever got from his starting position?
 */
func maxDistance(directions: [Direction]) -> Int {
    let points: [Point] = Point.origin.follow(directions: directions)
    let distances = points.map { $0.distance(to: .origin) }
    return distances.max()!
}

let answer2 = maxDistance(directions: directions)
print("Part 2: \(answer2)")
//: [Previous](@previous) | [Contents](Contents)
