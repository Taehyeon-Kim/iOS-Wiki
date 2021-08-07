# Equatable

가끔 가다보면 `Equatable`이라는 친구가 채택되어 있는 것을 볼 수 있습니다. 도대체 뭐하는 녀석일까요?
한 번 알아보도록 하겠습니다.

**Apple Developer에 들어가보는 것은 이제 국룰!!!**
예전부터 많은 선배(공부를 먼저 시작한 사람)들이 공식 Document는 진리라고 했던 것을 이제야 조금씩 느끼고 있는 하루하루입니다. 이제부터 공식 Docs를 꼼꼼히 읽어보는 습관을 가지려구요.

공식 Docs에 들어가보면 `Equatable`은 값의 동등성을 비교해주는 **프로토콜** **타입**이라고 나와있네요. 오호!

![스크린샷 2021-08-07 오후 8 49 58](https://user-images.githubusercontent.com/61109660/128602274-15b53c55-b2f4-4e5d-81c4-fa340d31fb60.png)

가장 Basic한 예시를 보면 다음과 같습니다.

`Kofi`라는 이름이 students 배열 안에 있는지 확인하는 코드인데요.
`nameToCheck` 값 자체로 배열 안에 포함되어 있는지 비교할 수 있습니다.

바로 대부분의 데이터 타입들이 `Equatable` 프로토콜을 준수하고 있기 때문이죠!
`Int` `String` `Double` `Bool` 등의 기본적인 데이터 타입 모두 `Equatable`을 따르고 있어요.

```swift
let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]

let nameToCheck = "Kofi"
if students.contains(nameToCheck) {
    print("\(nameToCheck) is signed up!")
} else {
    print("No record of \(nameToCheck).")
}
// Prints "Kofi is signed up!"
```

<br />

### 그렇다면 도대체 언제 사용해야할까!

사실 이게 궁금한거죠... 솔직히 정답은 없지만요...

**공식 Docs를 보면 컬렉션에서 특정 인스턴스를 검색할 때 편리하다고 나와있어요.**

![스크린샷 2021-08-07 오후 10 23 24](https://user-images.githubusercontent.com/61109660/128602275-cee6939c-891f-4b47-8c51-9dd919a0b23a.png)

오 그럼 정말 단순하게 생각해서 검색 관련 기능을 작성할때도 유용하지 않을까 싶습니다. 
물론 적용해봐야 알겠지만요.

또 한 번 생각해보면, 우리가 기본 데이터 타입만 사용하는 건 아니잖아요?
구조체(Struct), 클래스(Class), 열거형(Enum) 등 정말 여러가지 타입을 커스텀하게 만들어 사용합니다.

**이렇게 만든 타입을 가지고 생성한 인스턴스를 비교하는 상황이 생길 수도 있어요.**

**[Zedd님 블로그](https://zeddios.tistory.com/227)에 가보시면 한 가지 예시를 들어 설명하시고 있는데요.**

```swift
class A{
    var aNum : Int

    init(_ aNum :Int) {
        self.aNum = aNum
    }
}

if A(1) == A(2) //error!
{
}

출처: https://zeddios.tistory.com/227 [ZeddiOS]
```

**`Equatable` 프로토콜을 따르고 있지 않기 때문에 얘네가 같은지, 다른지 알 수 없답니다!!**

그래서 아래처럼 `Equatable`을 채택하고 사용해야합니다. 
한 가지 주의해야할 것은 구현해주어야 하는 메서드가 있어요.

`==` 메서드를 구현해주어야 `==` 를 사용할 수 있답니다.

```swift
// == 메서드 구현
class A: Equatable {    
    var aNum : Int

    init(_ aNum :Int) {
        self.aNum = aNum
    }

    static func == (lhs: A, rhs: A) -> Bool {
        return lhs.aNum == rhs.aNum
    }
}

if A(1) == A(2) {
    print("같아")
} else {
    print("달라")
}

// 달라
```

<br />

### 간단하게 예시를 하나 더 살펴봅시다.

1)번처럼 귀찮게 모든 프로퍼티를 비교할 필요없이 `contains` 메서드로 요소가 배열 안에 있는지 확인할 수 있습니다. 이게 다 `Equatable`을 채택했기 때문이죠. 뭔가 이런식으로 확인하고 싶은 상황이 생길 것 같은 느낌적인 느낌이...ㅎ

```swift
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

// 1) 일반적인 방법으로 특정 개체가 컬렉션에 속해있는지 파악할때
let object = korea
let containsObject = bucketList.contains { (country) -> Bool in
    return country.name == object.name &&
        country.capital == object.capital &&
        country.visited == object.visited
}
print(containsObject)

// 2) Equatable 프로토콜을 채택함으로써 내 개체가 컬렉션의 일부인지 쉽게 테스트 할 수 있다.
print(bucketList.contains(korea))
```

<br />

## 마무리

어려운 내용은 아니었던 것 같아요. 의미있는 시간이었습니다.
더 많은 Use-case가 있으면 좋겠지만, 이거는 코드 짜면서 감을 익혀야 할 것 같네요!

그럼 다음 시간에는 다른 프로토콜을 살펴보도록 하죠. 🙋🏻‍♂️

<br />

## 레퍼런스

[Apple Developer Documentation](https://developer.apple.com/documentation/swift/equatable)

[What is the Equatable Protocol in Swift?](https://medium.com/cleansoftware/what-is-the-equatable-protocol-in-swift-3cced3f28219)

[swift/Equatable.swift at main · apple/swift](https://github.com/apple/swift/blob/main/stdlib/public/core/Equatable.swift)

[Swift Protocols Don't Play Nice With Equatable. Or Can They? (Part One)](https://khawerkhaliq.com/blog/swift-protocols-equatable-part-one/)

[Swift Protocols Don't Play Nice With Equatable. Or Can They? (Part Two)](https://khawerkhaliq.com/blog/swift-protocols-equatable-part-two/)
