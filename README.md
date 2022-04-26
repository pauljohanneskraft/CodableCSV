![CodableCSV](https://user-images.githubusercontent.com/15239005/165396791-9bd01540-4327-4f39-9e23-988c7b0b5841.png)

Use CodableCSV for JSON-like  CSV file parsing using the Codable protocols in Swift.

## Custom coding options

Custom coding options include that you can define the character separating values in one row, the delimiter separating rows from each other, as well as enclosures which ensure that values could potentially include the separator or delimiter characters (currently only support for separator available).

### Sorting

You can define your own sorting order for header titles using a `CSVEncoder`. Simply put in a `(String, String) -> Bool` closure defining a < (less than) relation.

### Encoding

You can put in your custom encoders and decoders for more complex data structures. For encoding custom nested types register a `(C) -> String?` closure in your `CSVEncoder`. For decoding register a `(String) -> C?` closure in your `CSVDecoder`. Use this for all types, which are not in the following list: `Bool, Int8, Int16, Int32, Int64, Int, UInt8, UInt16, UInt32, UInt64, UInt, String`.

## Example

```swift
struct Person: Codable {
    var name: String
    var age: Int
}

let person0 = Person(name: "Paul", age: 22)
let person1 = Person(name: "Peter", age: 34)

let encoded: Data = CSVEncoder().encode([person0, person1])

let decoded: [Person] = CSVDecoder().decode(Person.self, from: encoded)
```

## Requirements

## Installation

CodableCSV is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CodableCSV'
```

## Author

Paul Kraft

## License

CodableCSV is available under the MIT license. See the LICENSE file for more info.
