//
//  Preview.swift
//  PreviewSample
//
//  Created by taehy.k on 2021/08/21.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
    import SwiftUI

    // MARK: - Preview for UIView
    public struct UIViewPreview<View: UIView>: UIViewRepresentable {
        
        public let view: View
        
        public init(_ builder: @escaping () -> View) {
            view = builder()
        }
        
        // MARK: - UIViewRepresentable
        public func makeUIView(context: Context) -> View {
            return view
        }
        
        public func updateUIView(_ view: View, context: Context) {
            view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }
    }

    // MARK: - Preview for UIViewController
    public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
        public let viewController: ViewController

        // MARK: - UIViewControllerRepresentable
        public func makeUIViewController(context: Context) -> ViewController {
            return viewController
        }

        public func updateUIViewController(_ uiViewController: ViewController, context: Context) {
            viewController.view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            viewController.view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }
    }

    enum DeviceType {
        case iPhoneSE2
        case iPhone8
        case iPhone12
        case iPhone12Pro
        case iPhone12ProMax

        func name() -> String {
            switch self {
            case .iPhoneSE2:
                return "iPhone SE"
            case .iPhone8:
                return "iPhone 8"
            case .iPhone12:
                return "iPhone 12"
            case .iPhone12Pro:
                return "iPhone 12 Pro"
            case .iPhone12ProMax:
                return "iPhone 12 Pro Max"
            }
        }
    }
    
    extension UIViewController {
        func showPreview(_ deviceType: DeviceType = .iPhone12Pro) -> some View {
            UIViewControllerPreview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
        }
    }

#endif


