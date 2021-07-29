# Generic(제네릭)

> Generic은 중복을 피하면서 매우 유연하고 재사용 가능한 함수와 타입을 작성할 수 있도록 해준다.  

사실 이론으로써 Generic은 그렇게 어려운 개념이 아닙니다. 기본적인 개념은 위에서 언급한 내용이 다라고 생각하는데요.  
(물론 이외에도 여러가지 설명은 붙을 수 있겠지만!)  

<br />

제네릭을 사용하려고 할 때에는 제네릭이 필요한 타입 또는 메서드 바로 뒤에 괄호(<>) 사이에 placeholder(ex: T, V, U)를 적어주어 사용합니다.
> 타입 또는 메서드 이름<타입 매개변수(T)>

<br />

**사용법은 어렵지 않습니다. 문제는 내 자신이 Generic을 사용이 필요한 곳에서 적절히 사용가능한가 이것이겠죠.**

<br />

## Generic 사용 예시(1) - 서버 통신 결과를 처리하기 위한 Enum

```swift
// NetworkResult.swift
enum NetworkResult<T> {
  case success(T)
  case requestErr(T)
  case pathErr
  case severErr
  case networkFail
}
```

제가 처음(엄밀히 말하자면 처음은 아니지만)으로 제네릭을 알게 모르게 사용했던 건   
서버 통신 결과를 각 경우에 따라 처리하기 위한 Enum을 만들었던 때인데요.    
~~(이 때는 Enum도 왜 사용해야 하는지도 모른 채 따라치고 있었다... 물론 지금도 잘하는 건 아니지만...)~~ 

**💁🏻 이어서 이야기를 해보죠.**   
서버와의 통신을 마치고 나면 Response(응답)이 돌아올텐데, Response의 경우 Success(성공) 또는 Fail(실패) 둘 중에 하나일텐데요.  
특히나 서버 통신이 **성공적으로 마무리되면 원하는 데이터**를 우리는 받게 되죠. 이것이 `.success(T)` 일 때의 처리일거예요.  
그 데이터를 가지고 요리조리 처리를 해서 멋진 결과물을 만들겠죠..?! ✨  

성공했을 때 어떤 `data`를 담아서 보내게 될 텐데, 이 때 `Generic`으로 타입을 만들어놓으면 어떤 값이 들어와도 편하게 후처리를 할 수 있습니다.

<br />

## Generic 사용 예시(2) - 처음에 우리를 엄청나게 괴롭혔던, Optional

```swift
enum Optional<T> {
  case none           // nil
  case some(T)        // optional value
}
```

세상에나... `Optional`도 `Enum`으로 구현되어 있고, 타입은 `Generic` 이라니...  
none은 아무 값도 설정되어 있지 않은 경우인 nil을 의미할테고,  
some은 어떤 값을 가지고 있다는 것이겠죠..? 그리고 `Generic`으로 타입을 만들어 놓았으니 그 값은 `Int`, `String` 등 어떤 타입이든 가질 수 있습니다.  

처음 봤을때는 꽤나 신선한 충격이었습니다... 알고나서 보니깐 좀 신기했거든요!

<br />

## Generic 사용 예시(3) - TableViewCell Extensions에서도 봤던 것 같은데...

```swift
// 익스텐션 적용 (전) - Dequeuing Cell
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: “TableViewCell”, for: indexPath) as! TableViewCell
    return cell
}
```

```swift
// 익스텐션 + 제네릭을 이용한 Dequeuing Cell
import UIKit

extension UITableView {
    func cell<T: UITableViewCell>(cellForRowAt indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: “\(T.self)”, for: indexPath) as? T else {
          fatalError("Could not find cell with reuseID \(T.self)")
        }
        return cell
    }
}
```

```swift
// 익스텐션 적용 (후) - Dequeuing Cell
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.cell(for: TableViewCell.self)
    return cell
}
```

네, 코드를 전부 볼 필요는 없구요...  
우리는 공부를 하다보면 좀 더 쉬운 방법, 편한 방법을 찾고는 합니다.  

TableView나 CollectionView를 사용하다보면 Cell을 Dequeue해서 사용하는 것은 필수인데요.  
Cell을 좀 더 편하게 Dequeue하려고 Extension을 사용하는 것을 적지 않게 볼 수가 있어요!  

그 동안 아무생각없이 사용하다가 다시 살펴보니 `<T: UITableViewCell>` 이 녀석도 Generic을 사용했던거잖아..!!  
근데 위에서 살펴봤던 것이랑 조금 다른 점이 있어요. 콜론(:)하고 특정 타입(UITableViewCell)이 명시되어있네요?  

타입 제약을 시켜주고 있는 것인데요. 'UITableViewCell 타입에만 cell 메서드를 동작하도록 하겠다' 정도의 의미로 생각하면 될 것 같아요.  
그럼 좀 더 안전하게 기능을 사용하도록 할 수 있겠죠!

<br />

## 마무리
그 동안 너무 당연하게 생각하고 사용하고 있었던 Generic이라는 친구에 대해서 알아보았는데요.   
사실 너무 생략한 부분이 많긴 하지만 사실 개념적인 부분은 다른 블로그나 책에 너무 잘 나와있어서   
대신에 평소에 궁금했었던, 그냥 넘어갔던 부분과 연관지어 몇 자 적어봤습니다.  

더 자세한 내용은 검색을 통해 찾아보면 좋을 것 같습니다.

<br />

제네릭을 한 마디로 말하면 요렇게 말할 수 있을까요..?
> Generic은 카멜레온 같은 녀석! 누구도 될 수 있다.  

마지막 말은 잊도록 합시다 ㅎㅎ

