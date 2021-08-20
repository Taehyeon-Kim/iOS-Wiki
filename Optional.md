# Optional (옵셔널)



<br />

> **우리는 옵셔널에 대해 물었을 때, 얼마나 잘 대답할 수 있을까?**

![optional](https://user-images.githubusercontent.com/61109660/129904098-075499a7-a7ef-4e21-833d-9848a6cd9ed0.png)


## Summary

- 옵셔널은 변수에 값이 있을 수도 있고, 없을 수도 있는 상태(`nil`)를 표현하기 위해 Swift에 도입된 개념입니다.
- 옵셔널은 Enum 형태로 정의되어 있고, 값의 있고 없음을 각 Case로 가지고 있습니다.
- 옵셔널로 표현된 값에 접근하는 방법으로는 Forced Unwrapping(강제 언래핑), Optional Binding(옵셔널 바인딩), Nil-Coalescing Operator(`Nil`병합연산자)가 있습니다.
- 옵셔널 체이닝을 통해서 옵셔널 바인딩으로 표현된 코드를 간결하게 작성할 수 있습니다.

---

## 옵셔널(Optional) 너란 녀석

### 옵셔널의 의미

자 우리는 근본있는 개발자이기 때문에 Apple 공식 문서를 보도록 하죠. ~~(사실 정의만 살펴볼거임..ㅎㅎ)~~

> A type that represents either a wrapped value or nil, the absence of a value.

내용을 한 번 이해해보자면 옵셔널은 변수에 값이 있을 수도 있고, 없을 수도 있는 상태(`nil`)를 표현하기 위해 Swift에 도입된 개념입니다.   
아직 이해가 안되었더라도 그냥 쭉 돌파해보죠.

### 옵셔널 사용 방법

값이 있을 수도 있고 없을 수도 있는 변수를 정의할 때는 변수의 유형 끝에 `?` 를 붙여서 옵셔널을 표현합니다. 
초기값을 정해주지 않으면 기본값은 `nil` 입니다. 

물음표를 붙인다고 하네요? 사실 정말 간단하게 이해를 해보면 물음표를 붙인다는 의미는 `확신이 없어서` 또는 `궁금해서` 요런 의미가 될 거예요. 그럼 조금 더 생각을 확장시켜볼게요.

```swift
var age: Int?
```

요렇게 age라는 변수를 옵셔널 Int형으로 선언을 해주었다는 의미는 무엇일까요? 
swift도 역시 프로그래밍 `언어`이기 때문에 한 번 해석을 해보면요.


`age`야, 너 `Int` 값을 가지고 있니? 라고 물어보고 있는 거예요. 
한 마디로 지금 age가 값을 가지고 있는지, 가지고 있지 않는지! 모르는거죠.  
~~(베일에 쌓여있는 age...)~~


값이 만약에 없는 경우에는 swift에서 값이 없음을 나타내는 `nil`일테고, 
어떤 값이 들어있다면 Int형의 어떤 값이겠죠?


자 그리고 값이 없음을 표현하는  `nil` 이라는 값은 정말 특별한 녀석이예요. 
Optional 형태가 아니면 `nil`값을 받아들일 수가 없어요.

```swift
var id: String
id = nil (x)
```

만약에 특정한 타입(Int, String, Float ...)의 변수에 nil을 넣으려고 한다면 에러가 발생합니다.
아이구,, 안전한 녀석

**아 오케이!! 그러면 변수가 어떤 값을 가질 수도 있고, 그 반대일 수도 있으니까 옵셔널을 쓰는 거구나!!**  
네 그럼 우리는 옵셔널이 어떤 녀석인지는 알았어요. 그럼 옵셔널 값을 사용하는 방법도 알아야겠죠?
차근차근 알아봅시다.

---

## 옵셔널을 뜯고 즐기는 방법, 언래핑(Unwrapping)

옵셔널을 사용하는 방법으로는 크게 2가지 범주로 나눌 수 있습니다. 
안전하게 처리하는 방법, 조금은 위험하지만 강제로 처리하는 방법이 있습니다.

> 가급적이면 강제 언래핑보다는 옵셔널 바인딩을 사용해서 언래핑 처리를 해주는 것이 좋습니다 :)

<br />

### 옵셔널 바인딩(`Optional Binding`) - `if ~ let` 구문, `guard ~ let` 구문

옵셔널 바인딩이란 옵셔널의 변수의 값을 검사한 다음에 값이 있다면 그 값을 다른 변수에 넣어주는 방법입니다.
이해가 안될 것 같으니 코드로 함께 살펴보죠.

```swift
// 1) if ~ let binding
var optionalId: String? = "2000389501"
var optionalPassword: String? = "xY23TdsY"

if let id = optionalId, password = optionalPassword {
  // 모두 값이 존재한다면 if문 내부의 코드 실행
}
```

```swift
// 2) guard ~ let binding
var name: String? = nil

guard let unwrapped = name else {
    print("You didn't provide a name!")
    return
}
```

두 가지 모두 표현식이 `nil`일 때와 그렇지 않을 때를 구분해서 코드를 실행하기 때문에 안전하게 에러를 처리할 수 있습니다.   
프로젝트 내에서 코드를 작성하다보면 정말 자주 볼 수 있는 코드 형식입니다!   
한 가지 예를 들어보면 `TableViewCell` 또는 `CollectionViewCell`을 반환할 때도 정말 자주 볼 수 있죠!

<br />

### 강제 언래핑(`force unwrapping`)

만약에 우리가 어떠한 값이 nil이 아니라고 확실히 알고 있는 경우 옵셔널을 강제로 풀 수 있습니다. 이를 우리는 강제 언래핑(force unwrapping)이라고도 부릅니다. `!` 를 우리는 사용하게 되는데요. 너 확실히 있는거 다 알아 당장 나와! 이런 느낌으로 봐도 괜찮을 것 같습니다.

예를 함께 볼까요?

```swift
// 예를 들어 숫자가 포함된 문자열이 있으면 우리는 Int로 타입 변환을 할 수 있습니다.
let str = "5"
let num = Int(str)

// 우리가 num이라는 변수에 반드시 정수만 담긴다는 것을 알고 있다면
let num = Int(str)! 

// 위와 같이 작성할 수 있습니다.
// Int?로가 아닙니다.
```

위에서도 언급했지만, 우리는 가급적 강제 언래핑보다 옵셔널 바인딩을 이용해서 옵셔널을 처리해주는 것이 좋습니다. 무심코 `!`를 사용했다가 예상치 못한 충돌을 만나서 앱이 죽어버릴 수가 있기 때문이죠~!

---

## 간결하고 안전한 선택, Nil 병합 연산자(Nil-Coalescing Operator)

가끔가다 코드를 작성하다보면 `??` 가 나오는 것을 보실 수 있습니다. 이것도 역시 옵셔널과 관련된 녀석인데요. 간단하게 생각해서 **값이 없는 경우에 대한 기본값 처리**라고 생각하면 편할 것 같습니다. 

아까 옵셔널은 값이 있을 수도 있고 없을 수도 있다고 했잖아요?
우리는 값이 없는 경우에 nil을 반환하는 것이 아니라 기본값을 정해주고 싶습니다. 이럴때 해당 연산자를 사용할 수가 있어요. if ~ else문으로 분기처리를 하지 않고도 코드를 간결하게 작성할 수 있겠네요!

```swift
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

// 위와 같이 옵셔널로 반환값을 선언해줬다면
// 만약 값이 없는 경우는 ?? 사용해서
// 기본값을 반환해줍니다.
let user = username(for: 15) ?? "Anonymous"
```

---

## 깔끔한 코드를 만드는 방법, 옵셔널 체이닝(Optional Chaining)

> 해당 부분은 전수열님의 [40시간만에 Swift로 iOS 앱 만들기](https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/Chapter-2/optionals.html) 를 참고했습니다.

옵셔널 체이닝을 사용하면, 코드를 좀 더 깔끔하게 간결하게 작성할 수 있습니다. 옵셔널 바인딩의 과정을 `?` 로 줄여줄 수가 있어요. 좋은 예시가 있어서 공유하려고 합니다.

```swift
let array: [String]? = []
var isEmptyArray = false

if let array = array, array.isEmpty {
  isEmptyArray = true
} else {
  isEmptyArray = false
}

isEmptyArray
```

```swift
let isEmptyArray = array?.isEmpty == true
```

옵셔널 체이닝을 이용하면 첫 번째 코드블럭을 두 번째처럼 정말 간결하게 작성할 수 있습니다.
빈 배열인지 확인하는 코드인데요. 빈 배열인지 확인하려면 `nil` 이 아니어야 하고, 요소가 없어야 합니다.

간단하게 말하면 옵셔널 체이닝이란 연결되어 있는 요소를 타고타고 들어가다가, 
중간에 `nil`을 만나면 바로 반환하는 것입니다. 아래 예시를 보면 이해가 더 쉬울 것 같습니다!

- `array`가 `nil`인 경우

    ```
      array?.isEmpty
      ~~~~~~
      여기까지 실행되고 `nil`을 반환합니다.

    ```

- `array`가 빈 배열인 경우

    ```
      array?.isEmpty
      ~~~~~~~~~~~~~~
      여기까지 실행되고 `true`를 반환합니다.

    ```

- `array`에 요소가 있는 경우

    ```
      array?.isEmpty
      ~~~~~~~~~~~~~~
      여기까지 실행되고 `false`를 반환합니다.
    ```

---

## 레퍼런스

[https://developer.apple.com/documentation/swift/optional](https://developer.apple.com/documentation/swift/optional)

[https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/Chapter-2/optionals.html](https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/Chapter-2/optionals.html)
