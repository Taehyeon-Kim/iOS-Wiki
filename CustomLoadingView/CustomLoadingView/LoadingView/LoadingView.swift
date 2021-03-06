//
//  LoadingView.swift
//  CustomLoadingView
//
//  Created by taehy.k on 2021/01/13.
//

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
