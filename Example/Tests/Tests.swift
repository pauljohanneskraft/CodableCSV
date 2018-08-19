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

    func testPrimitives() {
        XCTAssertThrowsError(try test(objects: ["hallo", "bye"]))
        XCTAssertThrowsError(try test(objects: [["hallo", "bye"], ["hallo", "bye"]]))
    }

    func testBigData() {
        struct SampleType: Codable {
            var id: String
            var code: String
            var checkOptional: Int?
        }
        let data = str.data(using: .utf8)!
        let decoded = try! CSVDecoder().decode(SampleType.self, from: data)
        print(decoded)
    }

    func test<C: Codable & Equatable>(objects: [C]) throws {
        let encoder = CSVEncoder()
        let decoder = CSVDecoder()

        for separator in [CSVSeparatorSymbol.comma, .colon, .custom("/")] {
            encoder.separatorSymbol = separator
            decoder.separatorSymbol = separator

            let encoded = try encoder.encode(objects)
            print(String(data: encoded, encoding: .utf8) ?? "nil")
            let decoded = try decoder.decode(C.self, from: encoded)
            XCTAssertEqual(objects, decoded)
        }
    }
}

let str = """
id,code
3,hallo
4,bye
5,good
7,check
8,test
2,what
"""
