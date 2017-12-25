import Foundation

public final class Program {
    private let startState: State
    private let checksumStep: Int
    private let states: [State : StateInfo]
    
    private var state: State
    private var tape = [0]
    private var cursor = 0
    
    public init?(input: String) {
        let sections = input.components(separatedBy: "\n\n")
        guard sections.count == 7, let first = sections.first else {
            return nil
        }
        
        let setupText = first
            .replacingOccurrences(of: Program.pattern, with: Program.replacement, options: .regularExpression, range: nil)
            .components(separatedBy: .newlines)
        
        guard setupText.count == 2,
            let state = State(setupText[0]),
            let checksumStep = Int(setupText[1]) else {
                return nil
        }
        
        startState = state
        
        self.state = state
        self.checksumStep = checksumStep
        
        let remaining = sections[1..<7]
        let stateInfos = remaining.flatMap(StateInfo.init)
        guard remaining.count == stateInfos.count else {
            return nil
        }
        
        states = stateInfos.reduce([:]) { dictionary, stateInfo in
            var dictionary = dictionary
            dictionary[stateInfo.state] = stateInfo
            return dictionary
        }
    }
}

extension Program {
    private static let pattern = """
        ^Begin in state ([A-F])\\.
        Perform a diagnostic checksum after (\\d+) steps\\.$
        """
    private static let replacement = "$1\n$2"
    
    public func runDiagnostic() -> Int {
        state = startState
        tape = [0]
        cursor = 0
        
        for _ in 0..<checksumStep {
            guard let stateInfo = states[state] else {
                fatalError()
            }
            
            run(stateInfo: stateInfo)
        }
        
        return tape.reduce(0) { $1 == 1 ? $0 + 1 : $0 }
    }
    
    private func run(stateInfo: StateInfo) {
        let value = tape[cursor]
        guard let action = stateInfo.actions[value] else {
            fatalError()
        }
        
        tape[cursor] = action.write
        (cursor, tape) = action.movement.move(cursor: cursor, tape: tape)
        state = action.state
    }
}
