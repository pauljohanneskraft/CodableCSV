import XCTest
import CodableCSV

class Tests: XCTestCase {
    
    func testPerson() {
        struct Person: Codable, Equatable {
            var name: String
            var age: Int
        }

        let person = Person(name: "Paul", age: 22)
        XCTAssertNoThrow(try test(objects: [person]))
    }

    func testNesting() {
        struct InnerType: Codable, Equatable {
            var name: String
        }
        struct OuterType: Codable, Equatable {
            var inner: InnerType
        }

        let object = OuterType(inner: InnerType(name: "Paul"))
        XCTAssertThrowsError(try test(objects: [object]))
    }

    func testAllPrimitives() {
        struct TestType: Codable, Equatable {
            var bool: Bool?
            var int: Int
            var double: Double
            var float: Float
            var int64: Int64
            var int32: Int32
            var int16: Int16
            var int8: Int8
        }

        let type0 = TestType(bool: false, int: 0, double: 1, float: 2, int64: 3, int32: 4, int16: 5, int8: 6)
        let type1 = TestType(bool: nil, int: 6, double: 5, float: 4, int64: 3, int32: 2, int16: 1, int8: 0)
        XCTAssertNoThrow(try test(objects: [type0, type1]))
    }

    func test<C: Codable & Equatable>(objects: [C]) throws {
        let encoded = try CSVEncoder().encode(objects)
        print(String(data: encoded, encoding: .utf8) ?? "nil")
        let decoded = try! CSVDecoder().decode(C.self, from: encoded)
        XCTAssertEqual(objects, decoded)
    }
}
