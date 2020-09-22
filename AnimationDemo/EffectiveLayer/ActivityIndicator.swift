//
//  ActivityIndicator.swift
//  AnimationDemo
//
//  Created by William on 2020/9/22.
//

import UIKit

class ActivityIndicatorLayer: CAReplicatorLayer {
    private let animationKey = "ActivityIndicator.animation"
    private let dotLayer = CALayer()
    
    var dotColor:UIColor = .orange {
        didSet {
            dotLayer.backgroundColor = dotColor.cgColor
        }
    }
    var dotSize:CGSize = CGSize(width: 14, height: 14) {
        didSet {
            refreshDotFrame()
        }
    }
    var dotCount:Int = 12 {
        didSet {
            self.instanceCount = dotCount
            refreshInstanceTransform()
            refreshAnimationDuration()
        }
    }
    var dotDuration:TimeInterval = 0.1 {
        didSet {
            self.instanceDelay = dotDuration
            refreshAnimationDuration()
        }
    }
    override func layoutSublayers() {
        super.layoutSublayers()
        refreshDotFrame()
    }
    override init(layer: Any) {
        super.init(layer: layer)
    }
    override init() {
        super.init()
        self.backgroundColor = UIColor.black.cgColor
        
        self.instanceCount = dotCount
        self.instanceDelay = dotDuration
        let angle = (2 * CGFloat.pi)/CGFloat(dotCount)
        //沿着z轴旋转
        self.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        self.repeatCount = Float.greatestFiniteMagnitude
        
        dotLayer.backgroundColor = dotColor.cgColor
        self.addSublayer(dotLayer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func refreshInstanceTransform() {
        let angle = (2 * CGFloat.pi)/CGFloat(dotCount)
        self.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
    }
    private func refreshAnimationDuration() {
        startAnimation()
    }
    private func refreshDotFrame() {
        dotLayer.frame = CGRect(x: (self.bounds.size.width - dotSize.width) * 0.5, y: 0, width: dotSize.width, height: dotSize.height)
    }
    func startAnimation() {
        stopAnimation()
        dotLayer.transform = CATransform3DMakeScale(0.3, 0.3, 0.3)
        let animationDuration:TimeInterval = dotDuration * Double(dotCount)
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = animationDuration
        animation.fromValue = 1
        animation.toValue = 0.3
        dotLayer.add(animation, forKey: animationKey)
    }
    func stopAnimation() {
        dotLayer.removeAnimation(forKey: animationKey)
    }
}
