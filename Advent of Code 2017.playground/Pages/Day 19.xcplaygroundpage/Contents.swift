//: [Previous](@previous) | [Contents](Contents)
/*:
 # Advent of Code 2017
 ## Day 19: A Series of Tubes
 
 Somehow, a network packet got lost and ended up here. It's trying to follow a routing diagram (your puzzle input), but it's confused about where to go.
 
 Its starting point is just off the top of the diagram. Lines (drawn with `|`, `-`, and `+`) show the path it needs to take, starting by going down onto the only line connected to the top of the diagram. It needs to follow this path until it reaches the end (located somewhere within the diagram) and stop there.
 
 Sometimes, the lines cross over each other; in these cases, it needs to continue going the same direction, and only turn left or right when there's no other option. In addition, someone has left **letters** on the line; these also don't change its direction, but it can use them to keep track of where it's been. For example:
 
 ```
     |
     |  +--+
     A  |  C
 F---|----E|--+
     |  |  |  D
     +B-+  +--+
 ```
 
 Given this diagram, the packet needs to take the following path:
 
 * Starting at the only line touching the top of the diagram, it must go down, pass through `A`, and continue onward to the first `+`.
 * Travel right, up, and right, passing through `B` in the process.
 * Continue down (collecting `C`), right, and up (collecting `D`).
 * Finally, go all the way left through `E` and stopping at `F`.
 
 Following the path to the end, the letters it sees on its path are `ABCDEF`.
 
 The little packet looks up at you, hoping you can help it find the way. **What letters will it see** (in the order it would see them) if it follows the path? (The routing diagram is very wide; make sure you view it without line wrapping.)
 */
typealias Vector = (point: Point, direction: Direction)

func run(input: String) -> (answer1: String, answer2: Int) {
    let grid = Grid(input)
    
    var current: GridNext = (grid.start, nil)
    var letters: [Character] = []
    var answer2 = 1;
    repeat {
        guard let next = grid.next(from: current.vector) else {
            break
        }
        
        if let letter = next.character {
            letters.append(letter)
        }
        
        answer2 += 1
        current = next
    } while true
    
    let answer1 = String(letters)
    
    return (answer1, answer2)
}

let example = """
    |
    |  +--+
    A  |  C
F---|--|-E---+
    |  |  |  D
    +B-+  +--+
"""

let (exampleAnswer1, exampleAnswer2) = run(input: example)
assert(exampleAnswer1 == "ABCDEF")

let input = loadInput()

let (answer1, answer2) = run(input: input)
print("Part 1: \(answer1)")
/*:
 ## Part Two
 
 The packet is curious how many steps it needs to go.
 
 For example, using the same routing diagram from the example above...
 
 ```
     |
     |  +--+
     A  |  C
 F---|--|-E---+
     |  |  |  D
     +B-+  +--+
 ```
 
 ...the packet would go:
 
 * `6` steps down (including the first line at the top of the diagram).
 * `3` steps right.
 * `4` steps up.
 * `3` steps right.
 * `4` steps down.
 * `3` steps right.
 * `2` steps up.
 * `13` steps left (including the `F` it stops on).
 
 This would result in a total of `38` steps.
 
 **How many steps** does the packet need to go?
 */
assert(exampleAnswer2 == 38)
print("Part 2: \(answer2)")
//: [Previous](@previous) | [Contents](Contents)
