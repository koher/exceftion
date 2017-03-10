import Foundation

open class Exception: Error {
    public let message: String
    public let cause: Error?
    public let file: String
    public let line: Int
    public let callStack: [String]
    
    public init(message: String, cause: Error? = nil, file: String = #file, line: Int = #line) {
        self.message = message
        self.cause = cause
        self.file = file
        self.line = line
        callStack = Thread.callStackSymbols
    }
}

extension Exception {
    public var fileName: String {
        return (file as NSString).lastPathComponent
    }
}

extension Exception: CustomStringConvertible {
    public var description: String {
        let fileName = (file as NSString).lastPathComponent
        let result = "\(type(of: self)): \(message) (\(fileName):\(line))\n\(callStack.map {"    \($0)"}.joined(separator: "\n"))"
        guard let cause = cause else {
            return result
        }
        return "\(result)\nCaused by \(cause)"
    }
}
