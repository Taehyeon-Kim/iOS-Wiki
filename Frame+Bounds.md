# frame과 bounds의 차이점

## Overview

애플 공식문서에 가보면 각각 definition이 다음과 같이 되어있다.

### Apple Developer

**frame**

> The frame rectangle, which describes the view’s location and size in its superview’s coordinate system.

**bounds**

> The bounds rectangle, which describes the view’s location and size in its own coordinate system.

<br />

해석을 해보면 다음과 같이 정리할 수 있다.   
이것이 둘의 차이점을 가장 간결하게 설명한 것이 아닐까 생각한다.

**frame은 Superview의 좌표계를 기준으로 뷰의 위치와 크기를 설명한다.  
bounds는 뷰 자신의 좌표계를 기준으로 뷰의 위치와 크기를 설명한다.**

> 조금 더 간단하게 정리를 해보면  
**frame은 상대적인 위치와 크기, bounds는 절대적인 위치와 크기**라고 보아도 무방하지 않을까 싶다.

<br />

이제 이 이후에 기준이 되는 좌표계가 다르면 어떤 차이점이 있는지?  
각각 어느 경우에 사용되는지·사용해야하는지는 더 알아봐야 할 것이다.

<br />

## 레퍼런스
[Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiview/1622621-frame)

[Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiview/1622580-bounds)

[iOS) Frame vs Bounds 제대로 이해하기 (1/3)](https://babbab2.tistory.com/44?category=831129)
