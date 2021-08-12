# Custom (Loading) View

인디케이터 뷰(Indicator View)라는 이름이 우리에겐 더 익숙한 로딩뷰에 대해서 커스텀해보는 시간을 가져봤습니다. 예전에 재미로 만들어 보았던 내용인데 다시 살펴보니 짚고 넘어갈 좋은 포인트가 몇 개 있더라구요?

사실 요즘에 생각해보면, 인디케이터는 그냥 기본 모양이 가장 낫다는 생각을 많이 합니다.
아래에 보이는 게 정말 default한 인디케이터입니다.

![indicator1](https://user-images.githubusercontent.com/61109660/129205113-5e49bb34-63ae-4917-a9ae-b0756fe86f67.png)
![indicator2](https://user-images.githubusercontent.com/61109660/129205109-aeb5d4c6-8930-426d-935f-4b2c37594d41.png)


**그런데도 굳이 커스텀을 해야겠다! 팀 내에서 정해진 커스텀 인디케이터가 있다고 하면, 애니메이션 파일을 띄우거나 하겠죠. 그래서 수작업으로 로딩뷰를 만드는 일은 거의 없을 것 같아요... 하하하**

**아, 그래서 오늘 쓰는 글이 필요가 없다는 것이 아니고!!**
**아마 개발을 하다보면 뷰를 커스텀 할 일이 생각보다 많이 생길텐데 조금은 익숙해지자 이런 이야기입니다~~**

간단하게 말해서,

> **(오늘의 핵심) 필요한 내용은 짚고 넘어가자~~ 이거입니다 ㅋㅋㅋㅋㅋㅋ**

말이 너무 많았네요... 죄송합니다😩

---

## 스크린샷

오늘 만들어 볼 뷰는 다음과 같아요.

![loading-view](https://user-images.githubusercontent.com/61109660/129205308-8342888e-3bb4-4fe6-b165-a1e5259cb661.gif) 

---

## 코드

- **LoadingView.xib**

    ![스크린샷 2021-08-12 오후 10 01 32](https://user-images.githubusercontent.com/61109660/129205424-d75034b8-e82c-46e5-81c4-8c6fb738686e.png)


- **LoadingView.swift**

    ```swift
    import UIKit

    class LoadingView: UIView {

        @IBOutlet var dots: [UIView]!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            initXIB()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func initXIB() {
            guard let view = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? UIView else {
                return
            }
            
            view.backgroundColor = .blue
            
            print("LoadingView Bounds", self.bounds)
            print("LoadingView Frame", self.frame)
            
            print("SubView Frame (전)", view.frame)
            view.frame = self.bounds
            print("SubView Frame (후)", view.frame)
            
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addSubview(view)
        }
        
        func startAnimation() {
            for index in 0..<dots.count {
                dots[index].transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                UIView.animate(withDuration: 0.6,
                               delay: Double(index+1) * 0.2,
                               options: [.repeat, .autoreverse],
                               animations: {
                                self.dots[index].transform = CGAffineTransform.identity
                               }, completion: nil)
            }
        }
    }
    ```

- **ViewController.swift**

    ```swift
    import UIKit

    class ViewController: UIViewController {
        
        private var loadingView: LoadingView?

        override func viewDidLoad() {
            super.viewDidLoad()
            
            setLoadingView()
        }
        
        func setLoadingView() {
            let loadingViewFrame = CGRect(x: 0, y: 0, width: 300, height: 200)
            loadingView = LoadingView(frame: loadingViewFrame)
            guard let loading = loadingView else { return }
            
            loading.center = self.view.center
            loading.startAnimation()
            self.view.addSubview(loading)
        }
    }
    ```

---

## 주목해볼만한 내용

- **UIView의 Custom xib**
- **간단한 Animation의 이해 (transform)**
- **IBOutlet Collection**
- `view.frame = self.bounds` **이건 무슨 의미일까..?**

## Xib 불러오기

xib에서 구성한 View를 가져오기 위해서는 nib 형태로 불러와야 합니다.

```swift
// nib 호출
// 하나의 UIView (첫번째, 하나의 UIView만 사용하기 때문에 .first 사용)
guard let view = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? UIView else {
    return
}
```

코드의 의미는 `nib`파일을 가져오는데 그중에서 첫번째 하위뷰(`.first`)를 가져오겠다! 요것이고
`UIView`로 캐스팅까지 진행해주고 있어요.

(요거는 좀 더 자세히 적도록 하겠습니다)

## 간단한 Animation의 이해

`transform`, `identify`

Transform의 종류로는 3가지가 있습니다.

- **Scale (크기)**
- Rotate (회전)
- Translate (이동)

이번에는 `Scale` 관련해서 `CGAffineTransform`을 사용했어요.

```swift
// MARK: - 프로젝트에서 사용된 코드
dots[index].transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
UIView.animate(withDuration: 0.6,
               delay: Double(index+1) * 0.2,
               options: [.repeat, .autoreverse],
               animations: {
                self.dots[index].transform = CGAffineTransform.identity
               }, completion: nil)

// MARK: - 기본 예시 코드
// 뷰의 넓이와 높이를 두 배씩 증가
UIView.animate(withDuration: 2.0) {
	customView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
}
```

`identify`는 원 상태로 복구하는 코드입니다.

```swift
CGAffineTransform.identity
```

## Frame vs Bounds

우선 Frame과 Bounds의 차이를 구분하는 것이 먼저일 것 같습니다.

저는 왜 `view.frame = self.bounds` 이 코드를 왜 사용하고 있는 것인지 궁금했는데 너무 간단한 개념이라서 그런건지 검색해도 잘 안나오더라구요.. 그래서 print()를 이리저리 찍어보니까 이해가 되었습니다.

view라는 것은 위에서도 알아보았듯이, LoadingView라는 객체의 하위 뷰(subview)입니다.
**ViewController에서는 LoadingView의 인스턴스를 생성하면서 슈퍼뷰의 프레임을 결정해주고 있는데요.** 

```swift
// ViewController.swift

func setLoadingView() {
    let loadingViewFrame = CGRect(x: 0, y: 0, width: 300, height: 200)
    loadingView = LoadingView(frame: loadingViewFrame)
    guard let loading = loadingView else { return }
    
    loading.center = self.view.center
    loading.startAnimation()
    self.view.addSubview(loading)
}
```

> **뷰의 프레임을 정해주지 않으면, 원하는 대로 뷰가 그려지지 않게 됩니다.**

만약에  `view.frame = self.bounds` 라는 코드를 통해서 하위뷰의 프레임을 정해주지 않으면,
얘는 정상적으로 그려지지 않을 것입니다. 

(LoadingView Frame을 300x200으로 잡아주었는데 하위뷰의 프레임을 정해주지 않으면, 기존에 잡혀있던 200x200이 그대로 사용되게 되어서 화면 상에 이상하게 표시됩니다.)

```swift
print("LoadingView Bounds", self.bounds)
print("LoadingView Frame", self.frame)

print("SubView Frame (전)", view.frame)
// 뷰의 프레임을 결정해주는 역할
view.frame = self.bounds
print("SubView Frame (후)", view.frame)
```

![스크린샷 2021-08-12 오후 9 31 53](https://user-images.githubusercontent.com/61109660/129205579-ce2a3842-fe8f-4a31-ba43-a3b55b5ada1e.png)


- (좌) 프레임 정상적으로 잡히지 않은 모습 / (우) 프레임이 정상적으로 잡힌 모습

    <img src = "https://user-images.githubusercontent.com/61109660/129205605-6b64a8be-1a00-4183-9378-722388b508a8.png" width = 250 />
    <img src = "https://user-images.githubusercontent.com/61109660/129205724-31464437-c86a-444e-9011-8cbf42aaeecc.png" width = 250 />


> 뷰의 frame을 슈퍼뷰의 bounds에 맞춰주면서 정상적으로 비율을 맞추어 그릴 수 있도록 합시다.

## IBOutlet Collection

스토리보드를 사용해서 개발을 진행할 때, 생각보다 유용한 것이 바로 Outlet Collection입니다.
아웃렛을 일일이 모두 선언하지 않고, 동일하게 반복되는 아웃렛을 배열의 형태로 가지는 것이죠.

코드 베이스로 이해하자면 그냥 UIView 등을 배열에 담아 사용하고 있는 것이라고 볼 수 있겠네요.

일일이 다섯개의 녹색 네모를 모두 선언할 필요없이 다음과 같이 코드를 사용하면 훨씬 깔끔하게 됩니다.

```swift
@IBOutlet var dots: [UIView]!
```

![스크린샷 2021-08-12 오후 9 41 48](https://user-images.githubusercontent.com/61109660/129206291-5483b36b-2efd-4c43-813d-237804fcd200.png)


---

## 깃허브

[iOS-Wiki/CustomLoadingView at master · Taehyeon-Kim/iOS-Wiki](https://github.com/Taehyeon-Kim/iOS-Wiki/tree/master/CustomLoadingView)

## 레퍼런스

[XIB를 사용한 UIView Custom 제대로 이해하기](https://medium.com/a-day-of-a-programmer/xib%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%9C-uiview-custom-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0-348a9b789496)

[[iOS] CustomView 만들기](https://furang-note.tistory.com/6)

[Frame vs Bounds in iOS](https://suragch.medium.com/frame-vs-bounds-in-ios-107990ad53ee)

[[Swift] Frame과 Bounds에 대해 알아보자](https://tong94.tistory.com/14)
