# Convenience initializer

이니셜라이저에서 크게 2가지를 살펴볼 수 있다.  
`Designated initializer`, `Covenience initializer`

차례대로 지정 이니셜라이저, 편의 이니셜라이저라고 해석해볼 수 있는데,  
지정 이니셜라이저는 클래스(구조체)내의 모든 프로퍼티가 초기화될 수 있도록 해주는 이니셜라이저이고,  
편의 이니셜라이저는 추가적인 작업을 할 수 있도록 해주는 보조 이니셜라이저이다.

Designated init 의 파라미터 일부를 기본값으로 설정해서 Convenience init 안에서 Designated init 을 호출해서 쓸 수 있다.

중요한 포인트는 다음과 같다.

> **Convenience init 은 같은 클래스에서 다른 이니셜라이저를 호출해야 한다.**

## 예시 1

이해를 해보면 여러 조건에 따라 초기화 작업을 진행할 수 있게 해주는 친구이다.
인스턴스를 생성할 때 넘기는 파라미터를 제한해줄 수 있다.

예를 들어서 생성 시점에 name만 파라미터로 넘기고 싶고, capacity는 그렇지 않다라고 한다면
2번째 코드 예시의 3번째 줄과 같이 코드를 작성할 수 있다.

convenience init()을 통해 이미 초기화 작업을 만들어 놓았기 때문에 가능한 것이다.


> 이해하기 좋은 예시가 있어서 그대로 가져왔습니다. 레퍼런스는 아래에 첨부하였습니다.

```swift
class Beverage {
  var name: String
  var capacity: Int
  // 지정 이니셜라이저 - 모든 인스턴스의 저장 프로퍼티 값 초기화(할당)
  init(name: String, capacity: Int) {
    self.name = name
    self.capacity = capacity
  }
  // 편의 이니셜라이저 - 지정 이니셜라이저를 통해 인스턴스 초기화
  convenience init(name: String) {
    self.init(name: name, capacity: 330)
  }
  // 편의 이니셜라이저 - 다른 편의 이니셜라이저를 통해 인스턴스 초기화
  convenience init() {
    self.init(name: "Fanta")
  }
}
```

```swift
// Beverage 인스턴스를 생성할 때
let beverage = Beverage()
let beverage = Beverage(name: , capacity: )
let beverage = Beverage(name: )
```

## 예시 2

다음과 같이 커스텀 뷰를 만들 때, convenience init()을 통해 초기 설정 값도 지정해줄 수 있다.

```swift
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
```

```swift
// MARK: - Usage
let button1 = CustomButton(backgroundColor: .systemRed, title: "아니오")
let button2 = CustomButton(backgroundColor: .systemGreen, title: "네")
```

## 레퍼런스

[Question-Archive/week-2.md at master · TTOzzi/Question-Archive](https://github.com/TTOzzi/Question-Archive/blob/master/contents/week-2.md#q-2)

[Initialization - The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html)

[Swift ) init과 convenience init의 차이](https://zeddios.tistory.com/141)
