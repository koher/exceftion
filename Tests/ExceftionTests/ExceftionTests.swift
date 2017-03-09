import XCTest
@testable import Exceftion

class ExceftionTests: XCTestCase {
    func testExample() {
        do {
            try baz()
        } catch let error {
            print(error)
        }
        
        do {
            try qux()
        } catch let error {
            print(error)
        }
    }
    
    func testCallStack() {
        do {
            try baz()
            XCTFail()
        } catch let error as FooException {
            XCTAssertEqual(error.message, "foo")
            XCTAssertNil(error.cause)
            let callStack = error.callStack
            XCTAssertTrue(callStack[0].hasPrefix("0   Exceftion "))
            XCTAssertTrue(callStack[0].contains("Exception"))
            XCTAssertTrue(callStack[1].hasPrefix("1   ExceftionTests "))
            XCTAssertTrue(callStack[1].contains("FooException"))
            XCTAssertTrue(callStack[2].hasPrefix("2   ExceftionTests "))
            XCTAssertTrue(callStack[2].contains("FooException"))
            XCTAssertTrue(callStack[3].hasPrefix("3   ExceftionTests "))
            XCTAssertTrue(callStack[3].contains("foo"))
            XCTAssertTrue(callStack[4].hasPrefix("4   ExceftionTests "))
            XCTAssertTrue(callStack[4].contains("bar"))
            XCTAssertTrue(callStack[5].hasPrefix("5   ExceftionTests "))
            XCTAssertTrue(callStack[5].contains("baz"))
            XCTAssertTrue(callStack[6].hasPrefix("6   ExceftionTests "))
            XCTAssertTrue(callStack[6].contains("testCallStack"))
        } catch {
            XCTFail()
        }
    }
    
    func testCause() {
        do {
            try qux()
            XCTFail()
        } catch let error as QuxException {
            XCTAssertEqual(error.message, "qux")
            let callStack = error.callStack
            XCTAssertTrue(callStack[0].hasPrefix("0   Exceftion "))
            XCTAssertTrue(callStack[0].contains("Exception"))
            XCTAssertTrue(callStack[1].hasPrefix("1   ExceftionTests "))
            XCTAssertTrue(callStack[1].contains("QuxException"))
            XCTAssertTrue(callStack[2].hasPrefix("2   ExceftionTests "))
            XCTAssertTrue(callStack[2].contains("QuxException"))
            XCTAssertTrue(callStack[3].hasPrefix("3   ExceftionTests "))
            XCTAssertTrue(callStack[3].contains("qux"))
            XCTAssertTrue(callStack[4].hasPrefix("4   ExceftionTests "))
            XCTAssertTrue(callStack[4].contains("testCause"))
            
            guard let cause = error.cause as? FooException else {
                XCTFail()
                return
            }
            XCTAssertEqual(cause.message, "foo")
            XCTAssertNil(cause.cause)
            let causeCallStack = cause.callStack
            XCTAssertTrue(causeCallStack[0].hasPrefix("0   Exceftion "))
            XCTAssertTrue(causeCallStack[0].contains("Exception"))
            XCTAssertTrue(causeCallStack[1].hasPrefix("1   ExceftionTests "))
            XCTAssertTrue(causeCallStack[1].contains("FooException"))
            XCTAssertTrue(causeCallStack[2].hasPrefix("2   ExceftionTests "))
            XCTAssertTrue(causeCallStack[2].contains("FooException"))
            XCTAssertTrue(causeCallStack[3].hasPrefix("3   ExceftionTests "))
            XCTAssertTrue(causeCallStack[3].contains("foo"))
            XCTAssertTrue(causeCallStack[4].hasPrefix("4   ExceftionTests "))
            XCTAssertTrue(causeCallStack[4].contains("bar"))
            XCTAssertTrue(causeCallStack[5].hasPrefix("5   ExceftionTests "))
            XCTAssertTrue(causeCallStack[5].contains("baz"))
            XCTAssertTrue(causeCallStack[6].hasPrefix("6   ExceftionTests "))
            XCTAssertTrue(causeCallStack[6].contains("qux"))
            XCTAssertTrue(causeCallStack[7].hasPrefix("7   ExceftionTests "))
            XCTAssertTrue(causeCallStack[7].contains("testCause"))
        } catch {
            XCTFail()
        }
    }

    static var allTests : [(String, (ExceftionTests) -> () throws -> Void)] {
        return [
            ("testCallStack", testCallStack),
            ("testCause", testCause),
        ]
    }
}

class FooException: Exception {}
func foo() throws {
    throw FooException(message: "foo")
}
func bar() throws {
    try foo()
}
func baz() throws {
    try bar()
}

class QuxException: Exception {}
func qux() throws {
    do {
        try baz()
    } catch let error {
        throw QuxException(message: "qux", cause: error)
    }
}
