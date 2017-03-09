import Foundation

open class Exception: Error {
    public let message: String
    public let cause: Error?
    public let callStack: [String]
    
    public init(message: String, cause: Error? = nil) {
        self.message = message
        self.cause = cause
        callStack = Thread.callStackSymbols
    }
}

extension Exception: CustomStringConvertible {
    public var description: String {
        let result = "\(type(of: self)): \(message)\n\(callStack.map {"    \($0)"}.joined(separator: "\n"))"
        guard let cause = cause else {
            return result
        }
        return "\(result)\nCaused by \(cause)"
    }
}
