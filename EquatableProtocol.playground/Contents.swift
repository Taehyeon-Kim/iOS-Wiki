/*
 https://useyourloaf.com/blog/swift-equatable-and-comparable/
 https://medium.com/cleansoftware/what-is-the-equatable-protocol-in-swift-3cced3f28219
 */

import UIKit

// MARK: - Practice

struct Country: Equatable {
    let name: String
    let capital: String
    var visited: Bool
}


let uk = Country(name: "영국", capital: "런던", visited: false)
let canada = Country(name: "캐나다", capital: "오타와", visited: false)
let japan = Country(name: "일본", capital: "도쿄", visited: false)
let korea = Country(name: "한국", capital: "서울", visited: true)
let france = Country(name: "프랑스", capital: "파리", visited: false)

let bucketList = [uk, canada, japan, france]

let object = korea
let containsObject = bucketList.contains { (country) -> Bool in
    return country.name == object.name &&
        country.capital == object.capital &&
        country.visited == object.visited
}

// 1) 일반적인 방법으로 특정 개체가 컬렉션에 속해있는지 파악할때
print(containsObject)

// 2) Equatable 프로토콜을 채택함으로써 내 개체가 컬렉션의 일부인지 쉽게 테스트 할 수 있다.
print(bucketList.contains(korea))


// MARK: - Basic Example 1

let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]

let nameToCheck = "Kofi"
if students.contains(nameToCheck) {
    print("\(nameToCheck) is signed up!")
} else {
    print("No record of \(nameToCheck).")
}

// MARK: - Basic Example 2

class A: Equatable {
    static func == (lhs: A, rhs: A) -> Bool {
        return lhs.aNum == rhs.aNum
    }
    
    var aNum : Int

    init(_ aNum :Int) {
        self.aNum = aNum
    }
}

if A(1) == A(1) //error!
{
    print("같아")
}

