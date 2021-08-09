## Variadic Parameters (가변인자)

임의의 개수의 인자를 받을 수 있는
필요한 반복 코드의 양을 줄여주어 깨끗하고 재사용 가능한 코드를 작성할 수 있다.

**지정된 타입의 0개 이상의 값을 수용한다.
⇒ 값을 받지 않을 수도 있다.**

### 예시 1. 기본적으로 print()도 가변인자를 파라미터로 가진다.

```swift
// print문
// 여러 인자를 한번에 출력할 수 있음
print(<#T##items: Any...##Any#>)
print("", "", "")
```

### 예시 2. 하위 뷰 추가 시 (✨ 되게 많이 사용하는 것을 볼 수 있음)

```swift
// 코드 베이스로 작업 시

// 1) subview를 추가하는 익스텐션
// UIView를 가변인자로 받고 있음
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
				
				// _ = views.map {
				// 		addSubview($0)
				// }
    }
}

// 기존에 반복되는 코드를 깔끔하게 작성할 수 있음
private func setup() {
 
 // view.addSubview(titleLabel)
 // view.addSubview(descriptionLabel)
 // view.addSubview(profileImageView)
 // view.addSubview(likeButton)
    
    view.addSubviews(titleLabel, descriptionLabel, profileImageView, likeButton)
}
```

### 예시 3. 데이터 전송 시

```swift
// When using a variadic parameter, any number of arguments can
// be passed, and the compiler will automatically organize them
// into an array.
func send(_ message: Message, attaching attachments: Attachment...) {
    ...
}

// Passing no variadic arguments:
send(message)

// Passing either a single, or multiple variadic arguments:
send(message, attaching: image)
send(message, attaching: image, document)
```

### 예시 4. 계산을 할 때

```swift
func addIntegers(integers: Int...) {
		// to do ...
}
```

```swift
func calculateSum(_ nums: Int...) -> Int {
  // Here nums is a variadic parameter which can be accessed as an array if more than 1 element is passed to it.
  return nums.reduce(0, +) // We'll come to reduce in a bit
}

calculateSum(1,2,3,4,5)
```
