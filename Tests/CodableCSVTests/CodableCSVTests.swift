import XCTest
@testable import CodableCSV

final class CodableCSVTests: XCTestCase {

    static var allTests = [
        ("testEnclosure", testEnclosure),
    ]

    func testEnclosure() {
        struct EnclosureTestType: Codable, Equatable {
            var title0: String
            var title1: String
            var title2: String
        }

        let object0 = EnclosureTestType(title0: "hallo", title1: "5,4", title2: "4;3")
        let object1 = EnclosureTestType(title0: ",,,", title1: "5-4", title2: "4;3")
        let object2 = EnclosureTestType(title0: ".", title1: "5\\4", title2: "4;3")

        XCTAssertNoThrow(try test(objects: [object0, object1, object2]))

        let objects = (0..<100).flatMap { _ in [object0, object1, object2] }
        measure {
            measurableTest(objects: objects)
        }
    }

    func testPerson() {
        struct Person: Codable, Equatable {
            var name: String
            var age: Int
        }

        let person = Person(name: "Paul", age: 22)
        XCTAssertNoThrow(try test(objects: [person]))

        let objects = (0..<100).map { _ in person }
        measure {
            measurableTest(objects: objects)
        }
    }

    func testNesting() {
        struct InnerType: Codable, Equatable {
            var firstName: String
            var lastName: String
            var children: [OuterType]
        }

        struct OuterType: Codable, Equatable, CustomStringConvertible {
            var inner: InnerType

            var description: String {
                "Outer(firstName: \(inner.firstName), lastName: \(inner.lastName), children: \(inner.children))"
            }
        }

        let object = OuterType(inner: InnerType(firstName: "Paul", lastName: "Kraft", children: [
            OuterType(inner: InnerType(firstName: "Child1", lastName: "Kraft", children: [])),
        ]))

        print([object])
        XCTAssertNoThrow(try test(objects: [object, object]))

        let objects = (0..<100).map { _ in object }
        measure {
            measurableTest(objects: objects)
        }
    }

    func testNesting2() {
        struct InnerType: Codable, Equatable {
            var name: String
        }
        struct OuterType: Codable, Equatable {
            var age: Int
            var inner: InnerType
        }

        let objects = [OuterType(age: 10, inner: InnerType(name: "Paul")), OuterType(age: 12, inner: InnerType(name: "Peter"))]

        let encodingExpectation = self.expectation(description: "encoder")
        encodingExpectation.expectedFulfillmentCount = 2
        var encoder = CSVEncoder()
        encoder.register(for: InnerType.self) { inner in
            encodingExpectation.fulfill()
            return inner.name
        }
        var decoder = CSVDecoder()
        decoder.register(InnerType.init)

        let encoded = try! encoder.encode(objects)
        wait(for: [encodingExpectation], timeout: 2)
        print(String(data: encoded, encoding: .utf8) ?? "nil")
        let decoded = try! decoder.decode(OuterType.self, from: encoded)
        XCTAssertEqual(objects, decoded)

        let o = (0..<100).flatMap { _ in objects }
        measure {
            measurableTest(objects: o)
        }
    }

    func testAllPrimitives() {
        struct TestType: Codable, Equatable {
            var bool: Bool?
            var int: Int
            var double: Double
            var float: Float
            var int64: Int64
            var int32: Int32?
            var int16: Int16
            var int8: Int8
        }

        let type0 = TestType(bool: false, int: 0, double: 1, float: 2, int64: 3, int32: nil, int16: 5, int8: 6)
        let type1 = TestType(bool: nil, int: 6, double: 5, float: 4, int64: 3, int32: 2, int16: 1, int8: 0)
        XCTAssertNoThrow(try test(objects: [type0, type1]))

        let objects = (0..<100).flatMap { _ in [type0, type1] }
        measure {
            measurableTest(objects: objects)
        }
    }

    func testPrimitives() {
        XCTAssertNoThrow(try test(objects: [["hallo", "bye", "test"], ["hallo", "bye"]]))
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

    func measurableTest<C: Codable & Equatable>(objects: [C]) {
        var encoder = CSVEncoder()
        var decoder = CSVDecoder()

        encoder.nesting = .chain(separator: "_")
        decoder.nesting = .chain(separator: "_")

        guard let encoded = try? encoder.encode(objects) else { return }
        let symbol = CSVSeparator.detect(from: encoded,
                                         candidates: [.comma, .colon, .custom("/")],
                                         delimiter: encoder.delimiter,
                                         enclosure: encoder.enclosure)
        XCTAssertEqual(symbol?.character, encoder.separator.character)
        guard let decoded = try? decoder.decode(C.self, from: encoded) else { return }
        XCTAssertEqual(objects, decoded)
    }

    func test<C: Codable & Equatable>(objects: [C]) throws {
        var configuration = CSVConfiguration()
        configuration.nesting = .chain(separator: "_")

        var encoder = CSVEncoder(configuration: configuration)
        var decoder = CSVDecoder(configuration: configuration)

        let separators = [CSVSeparator.comma, .colon, .custom("/")]

        for separator in separators {
            encoder.separator = separator
            decoder.separator = separator

            let encoded = try encoder.encode(objects)
            print("-- START ENCODED --")
            print(String(data: encoded, encoding: .utf8) ?? "nil")
            print("-- End ENCODED --")

            let symbol = CSVSeparator.detect(from: encoded,
                                             candidates: separators,
                                             delimiter: encoder.delimiter,
                                             enclosure: encoder.enclosure)
            XCTAssertEqual(symbol?.character, separator.character)
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
