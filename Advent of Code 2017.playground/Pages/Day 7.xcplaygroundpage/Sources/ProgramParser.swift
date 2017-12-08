import Foundation

public final class ProgramParser {
    private let programList: [String]
    private var cache: [Program] = []
    
    private struct ProgramInfo {
        let name: String
        let weight: Int
        let children: [String]
    }
    
    public init(programList: [String]) {
        self.programList = programList
    }
    
    public func parse() -> Program {
        let programInfos = programList.map(parseLine)
        let programs = programInfos.map { $0.name }.map { createProgram(name: $0, programInfos: programInfos) }
        
        guard let root = programs.first(where: { $0.parent == nil }) else {
            fatalError()
        }
        
        return root
    }
    
    private func createProgram(name: String, programInfos: [ProgramInfo]) -> Program {
        if let item = cache.first(where: { $0.name == name }) {
            return item
        }
        
        guard let programInfo = programInfos.first( where: { $0.name == name }) else {
            fatalError()
        }
        
        let children = programInfo.children.map { createProgram(name: $0, programInfos: programInfos) }
        let program = Program(name: programInfo.name, weight: programInfo.weight, children: children)
        cache.append(program)
        return program
    }
    
    private func parseLine(programLine: String) -> ProgramInfo {
        let splitFromChildren = programLine.components(separatedBy: " -> ")
        let children: [String]
        
        if splitFromChildren.count == 2 {
            let childList = splitFromChildren[1]
            children = childList.components(separatedBy: ", ")
        } else {
            children = []
        }
        
        let nameAndWeight = splitFromChildren[0]
        let parts = nameAndWeight.components(separatedBy: .whitespaces)
        let name = parts[0]
        let weightText = parts[1].replacingOccurrences(of: "\\((\\d+)\\)", with: "$1", options: .regularExpression, range: nil)
        let weight = Int(weightText)!
        return ProgramInfo(name: name, weight: weight, children: children)
    }
}
