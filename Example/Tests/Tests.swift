import XCTest
import CodableCSV

class Tests: XCTestCase {
    
    func testExample() {
        struct Person: Codable {
            var name: String
            var age: Int
        }

        let person = Person(name: "Paul", age: 22)
        let data = try! CSVEncoder().encode([person])
        print(String(data: data, encoding: .utf8)!)
        let objects = try! CSVDecoder().decode(Person.self, from: data)
        print(objects, person)
    }
}
