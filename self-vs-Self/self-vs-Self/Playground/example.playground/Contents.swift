import UIKit

// MARK: - Example 1
struct Person {
    var name: String
    var age: Int
    
    // 모든 저장 프로퍼티는 항상 초기화가 이뤄져야 한다.
    init(name: String, age: Int) {
        self.name = name // self는 인스턴스 자기 자신을 가리킨다.
        self.age = age
    }
    
    // 값 타입의 프로퍼티를 강제로 수정하기 위해서는 mutating 키워드를 붙여준다.
    mutating func makeDisguise() -> Self {
        name = "Bob"
        age = Int.random(in: 1...99)
        return self
    }
}

var alice = Person(name: "Alice", age: 22)
print(alice)
print(alice.makeDisguise())

// MARK: - Example 2
extension Numeric {
    func squared() -> Self {
        return self * self
    }
}

let number = 32
print(number.squared()) // 1024

// MARK: - Example 3
extension Sequence where Element: Numeric {
    func squareAll() -> [Self.Element] {
        return map { $0 * $0 }
    }
}

print((0...10).squareAll())
// [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
