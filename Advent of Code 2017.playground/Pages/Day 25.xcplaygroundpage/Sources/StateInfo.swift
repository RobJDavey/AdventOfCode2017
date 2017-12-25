import Foundation

typealias Action = (write: Int, movement: Movement, state: State)

struct StateInfo {
    let state: State
    let actions: [Int : Action]
}

extension StateInfo {
    private static let pattern = """
        ^In state ([A-F]):
          If the current value is (\\d):
            - Write the value (\\d)\\.
            - Move one slot to the (left|right)\\.
            - Continue with state ([A-F])\\.
          If the current value is (\\d):
            - Write the value (\\d)\\.
            - Move one slot to the (left|right)\\.
            - Continue with state ([A-F])\\.$
        """
    private static let replacement = "$1\n$2\n$3\n$4\n$5\n$6\n$7\n$8\n$9"
    
    init?(input: String) {
        let components = input
            .replacingOccurrences(of: StateInfo.pattern, with: StateInfo.replacement, options: .regularExpression, range: nil)
            .components(separatedBy: .newlines)
        
        guard components.count == 9,
            let state = State(components[0]),
            let ifValue1 = Int(components[1]),
            let writeValue1 = Int(components[2]),
            let movement1 = Movement(rawValue: components[3]),
            let contineState1 = State(components[4]),
            let ifValue2 = Int(components[5]),
            let writeValue2 = Int(components[6]),
            let movement2 = Movement(rawValue: components[7]),
            let contineState2 = State(components[8]) else {
                return nil
        }
        
        self.state = state
        self.actions = [
            ifValue1 : (writeValue1, movement1, contineState1),
            ifValue2 : (writeValue2, movement2, contineState2)
        ]
    }
}
