import XCTest
import CodableCSV

class Tests: XCTestCase {

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

        measure {
            let objects = (0..<200).flatMap { _ in [object0, object1, object2] }
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

        measure {
            measurableTest(objects: [person])
        }
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

        measure {
            measurableTest(objects: [object])
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
        let encoder = CSVEncoder()
        encoder.register(encoder: { (inner: InnerType) in inner.name })
        let decoder = CSVDecoder()
        decoder.register(decoder: InnerType.init)

        let encoded = try! encoder.encode(objects)
        print(String(data: encoded, encoding: .utf8) ?? "nil")
        let decoded = try! decoder.decode(OuterType.self, from: encoded)
        XCTAssertEqual(objects, decoded)

        measure {
            measurableTest(objects: objects)
        }
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

        measure {
            measurableTest(objects: [type0, type1])
        }
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

    func measurableTest<C: Codable & Equatable>(objects: [C]) {
        let encoder = CSVEncoder()
        let decoder = CSVDecoder()

        guard let encoded = try? encoder.encode(objects) else { return }
        let symbol = CSVSeparator.detect(from: encoded, encoding: .utf8, possibleCharacters: [",", ";", "/"], delimiter: encoder.delimiter, enclosure: encoder.enclosure)
        XCTAssertEqual(symbol?.character, encoder.separator.character)
        guard let decoded = try? decoder.decode(C.self, from: encoded) else { return }
        XCTAssertEqual(objects, decoded)
    }

    func test<C: Codable & Equatable>(objects: [C]) throws {
        let encoder = CSVEncoder()
        let decoder = CSVDecoder()

        let separators = [CSVSeparator.comma, .colon, .custom("/")]
        let separatorCharacters = Set(separators.map { $0.character })

        for separator in separators {
            encoder.separator = separator
            decoder.separator = separator

            let encoded = try encoder.encode(objects)
            print(String(data: encoded, encoding: .utf8) ?? "nil")

            let symbol = CSVSeparator.detect(from: encoded, encoding: .utf8, possibleCharacters: separatorCharacters, delimiter: encoder.delimiter, enclosure: encoder.enclosure)
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
