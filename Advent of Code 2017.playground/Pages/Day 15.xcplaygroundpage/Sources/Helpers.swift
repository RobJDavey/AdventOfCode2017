import Foundation

func createGenerator(startingAt first: Int, factor: Int) -> UnfoldSequence<Int, (Int?, Bool)> {
    var generator = sequence(first: first) { value in
        (value * factor) % 2147483647
    }
    _ = generator.next()
    return generator
}

func getBinary(value: Int) -> String {
    let last16Bits = String(value, radix: 2)
        .paddingLeft(toLength: 16, withPad: "0")
        .suffix(16)
    return String(last16Bits)
}

func runSequence(iterations: Int, keepA: (Int) -> Bool = { _ in true }, keepB: (Int) -> Bool = { _ in true }) -> Int {
    let generatorAStart = 591
    let generatorAFactor = 16807
    let generatorBStart = 393
    let generatorBFactor = 48271
    
    var generatorA = createGenerator(startingAt: generatorAStart, factor: generatorAFactor)
    var generatorB = createGenerator(startingAt: generatorBStart, factor: generatorBFactor)
    
    var answer = 0
    
    for _ in 0..<iterations {
        var a: Int
        var b: Int
        
        repeat {
             a = generatorA.next()!
        } while !keepA(a)
        
        repeat {
            b = generatorB.next()!
        } while !keepB(b)
        
        let aBinary = getBinary(value: a)
        let bBinary = getBinary(value: b)
        
        if aBinary == bBinary {
            answer += 1
        }
    }

    return answer
}

public func runPart1() -> Int {
    return runSequence(iterations: 40_000_000)
}

public func runPart2() -> Int {
    return runSequence(iterations: 5_000_000, keepA: { a in a % 4 == 0 }, keepB: { b in b % 8 == 0 })
}
