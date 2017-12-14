import Foundation

extension String {    
    public func paddingLeft(toLength length: Int, withPad padString: String, startingAt padIndex: Int = 0) -> String {
        let padLength = max(0, length - count)
        let prefix = String().padding(toLength: padLength, withPad: padString, startingAt: padIndex)
        return "\(prefix)\(self)"
    }
}
