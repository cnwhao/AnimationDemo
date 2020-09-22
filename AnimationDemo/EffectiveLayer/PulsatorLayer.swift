//
//  PulsatorLayer.swift
//  AnimationDemo
//  圆形向外扩展波形
//  Created by William on 2020/9/21.
//

import UIKit

class PulsatorLayer: CAReplicatorLayer {
    private let animationKey = "PulsatorLayer.animation"
    private let pulseLayer = CALayer()
    override init(layer: Any) {
        super.init(layer: layer)
    }
    override init() {
        super.init()
        self.instanceCount = 5
        self.instanceDelay = 0.6
        pulseLayer.backgroundColor = UIColor.orange.cgColor
        self.addSublayer(pulseLayer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSublayers() {
        super.layoutSublayers()
        let layer = pulseLayer
        layer.frame = self.bounds
        layer.cornerRadius = self.bounds.size.height * 0.5
    }
    var fromColor:UIColor = .orange {
        didSet {
            pulseLayer.backgroundColor = fromColor.cgColor
        }
    }
    var pulseCount:Int = 5 {
        didSet {
            self.instanceCount = pulseCount
        }
    }
    var pulseDuration:TimeInterval = 0.6 {
        didSet {
            self.instanceDelay = pulseDuration
        }
    }
    func startAnimation() {
        stopAnimation()
        let animationDuration = Double(pulseCount) * pulseDuration
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.duration = animationDuration
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.duration = animationDuration
        
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 2
        
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        
        let group = CAAnimationGroup()
        group.duration = animationDuration
        group.animations = [scaleAnimation, opacityAnimation]
        group.repeatCount = Float.greatestFiniteMagnitude
        pulseLayer.add(group, forKey: animationKey)
    }
    func stopAnimation() {
        pulseLayer.removeAnimation(forKey: animationKey)
    }
}
