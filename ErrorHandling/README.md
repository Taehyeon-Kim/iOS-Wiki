
## 에러 핸들링

- 일부 작업은 항상 실행을 완료하거나 유용한 출력을 생성한다고 보장하지 않는다.

    ⇒ 프로그램이 동작하다보면 분명 정상 동작을 하지 못하는 경우가 발생한다.

- Enum(열거형)은 에러의 여러 상황을 그룹핑하는데 유용하다.

    ⇒ 관련값(연관값)을 사용하여 에러 특성에 대한 추가 정보를 전달할 수 있다.

### 에러 표현하기

```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
```

`throw` 구문을 사용해서 코인이 더 필요하다고 에러 처리를 할 수 있다.

```swift
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```

### 에러 처리의 4가지 방법

`do-catch` `optional` `try try? try!` `try ~ catch`

1. **Throwing Functions**

    ```swift
    struct Item {
        var price: Int
        var count: Int
    }

    class VendingMachine {
        var inventory = [
            "Candy Bar": Item(price: 12, count: 7),
            "Chips": Item(price: 10, count: 4),
            "Pretzels": Item(price: 7, count: 11)
        ]
        var coinsDeposited = 0

    		// 던지기 함수 (Throwing Functions)
        func vend(itemNamed name: String) throws {
            guard let item = inventory[name] else {
                throw VendingMachineError.invalidSelection
            }

            guard item.count > 0 else {
                throw VendingMachineError.outOfStock
            }

            guard item.price <= coinsDeposited else {
                throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
            }

            coinsDeposited -= item.price

            var newItem = item
            newItem.count -= 1
            inventory[name] = newItem

            print("Dispensing \(name)")
        }
    }
    ```

    초기화 함수에서도 `throws` 가 가능하네?

    ```swift
    struct PurchasedSnack {
        let name: String
        init(name: String, vendingMachine: VendingMachine) throws {
            try vendingMachine.vend(itemNamed: name)
            self.name = name
        }
    }
    ```

2. **do ~ catch**

    ```swift
    var vendingMachine = VendingMachine()
    vendingMachine.coinsDeposited = 8
    do {
        try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
        print("Success! Yum.")
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    } catch {
        print("Unexpected error: \(error).")
    }
    // Prints "Insufficient funds. Please insert an additional 2 coins."
    ```

3. **에러를 옵셔널 값으로 변환 (try?)**

    `try?` 표현식을 평가하는 동안 에러가 발생하면 `return` 값은 `nil`이 된다.

    ```swift
    func someThrowingFunction() throws -> Int {
        // ...
    }

    let x = try? someThrowingFunction()

    let y: Int?
    do {
        y = try someThrowingFunction()
    } catch {
        y = nil
    }
    ```

    `try?` 를 사용하여 다음과 같이 간결한 에러 처리 코드를 작성할 수 있다. ✨

    여러 접근 방식을 통해서 `data`를 가져오고 있는데, 모든 접근 방식이 실패하면 `nil`을 리턴한다.

    ```swift
    func fetchData() -> Data? {
        if let data = try? fetchDataFromDisk() { return data }
        if let data = try? fetchDataFromServer() { return data }
        return nil
    }
    ```

4. **에러 전파 비활성화**

    던지는 함수 또는 메서드가 실제로 런타임 에러를 발생하지 않는다는 사실을 알고 있다면
    `try!` 를 사용해서 에러가 발생하지 않는다고 호출을 래핑할 수 있다.

    **⇒ 만약에 에러가 생기면 런타임 에러가 발생한다.**

    **다음과 같이 런타임 에러가 발생하지 않는다고 확신하는 경우 아래처럼 코드를 작성할 수 있다.**

    > 예를 들어 다음의 코드는 주어진 경로의 이미지를 로드하거나 이미지를 로드할 수 없을 때는 에러를 발생하는 loadImage(atPath:) 함수를 사용합니다. 이러한 경우 이미지는 이미지는 애플리케이션과 함께 제공되고 런타임에 에러가 발생하지 않으므로 에러 전파를 비활성화 하는 것이 적절합니다.

    ```swift
    let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
    ```

    옵셔널과 형태가 정말 비슷해보이는데 왠만하면 안전하게 `try?` 문을 사용하는 것이 좋지 않을까 생각한다.

> `defer` 구문 (다음에 다시 정리)

---

<br />

## 실습

### **예시 1) 로그인 또는 회원가입 처리**

에러핸들링과 함께 Alert를 같이 사용하는 경우를 종종 볼 수 있다.

### **주목해야할 포인트!**

- Custom ErrorType 지정
- `throw function`과 `do ~ catch`를 통해 에러 핸들링
- 커스텀 뷰에 대한 코드는 생략하였습니다.

```swift
// ViewController.swift

import UIKit

// MARK: - Login Error Type
// 빈 Error 프로토콜을 채택하여 사용한다.
enum loginErrorType: Error {
    case isNotCompleted             // 필드가 모두 채워지지 않았을때
    case isValidEmail               // 이메일 형식이 올바르지 않았을때
    case incorrectPasswordLength    // 비밀번호 길이가 올바르지 않았을때
}

class ViewController: UIViewController {
    
    // MARK: - Views
    
    let idTextField = CustomTextField(placeholder: "input id or email")
    let passwordTextField = CustomTextField(placeholder: "input password")
    let loginButton = CustomButton(backgroundColor: .systemYellow, title: "Login")

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: Configure

    private func setup() {
        view.addSubviews(loginButton, idTextField, passwordTextField)
        
        idTextField.widthAnchor.constraint(equalToConstant: 380).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        idTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalToConstant: 380).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20).isActive = true
        
        loginButton.widthAnchor.constraint(equalToConstant: 380).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func loginButtonTapped(_ sender: UIButton) {
        do {
            try login()
            Alert.showBasic(title: "Login Success", message: "로그인 성공", vc: self)
        } catch loginErrorType.isNotCompleted {
            Alert.showBasic(title: "Incomplete Form", message: "필드를 모두 채워주세요", vc: self)
        } catch loginErrorType.isValidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "이메일 형식을 지켜주세요", vc: self)
        } catch {
            Alert.showBasic(title: "Incorrect Password Length", message: "비밀번호를 8자리 이상 입력해주세요", vc: self)
        }
    }
    
    private func login() throws {
        guard let email = idTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        guard !email.isEmpty && !password.isEmpty else { throw loginErrorType.isNotCompleted }
        guard email.isVaildEmail else { throw loginErrorType.isValidEmail }
        guard password.count >= 8 else { throw loginErrorType.incorrectPasswordLength }
    }
}
```

<br />

### 시뮬레이터 GIF

![error_handling](https://user-images.githubusercontent.com/61109660/128666345-0ae75b90-0efb-4c00-b6c4-7398b5d40f4f.gif)


<br />

### 레퍼런스 

[Apple Developer Documentation](https://developer.apple.com/documentation/swift/cocoa_design_patterns/handling_cocoa_errors_in_swift)

[에러 처리 (Error Handling)](https://bbiguduk.gitbook.io/swift/language-guide-1/error-handling#handling-errors)

[Swift Error Handling - Do, Try, Catch - iOS Interview Question Series](https://www.youtube.com/watch?v=Lrc-MX8WgNc)

[Swift Error handling best practices](https://stackoverflow.com/questions/49628288/swift-error-handling-best-practices)
