//
//  UIViewPreview.swift
//  FrameBoundsSample
//
//  Created by taehy.k on 2021/08/20.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

// 제네릭에 UIView로 제약을 줘서 구현
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> some UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}


// MARK: - Preview for UIViewController @available(iOS 13.0, *)
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    
    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        viewController.view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        viewController.view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
