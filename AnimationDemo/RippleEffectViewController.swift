//
//  RippleEffectViewController.swift
//  AnimationDemo
//
//  Created by William on 2020/9/21.
//

import UIKit

class RippleEffectViewController: UIViewController {
    private let pulsatorLayer = PulsatorLayer()
    private let indicatorLayer = ActivityIndicatorLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.view.layer.addSublayer(pulsatorLayer)
        pulsatorLayer.frame = CGRect(x: 160, y: 160, width: 40, height: 40)
        pulsatorLayer.pulseCount = 5
        pulsatorLayer.pulseDuration = 0.6
        pulsatorLayer.startAnimation()
        
        self.view.layer.addSublayer(indicatorLayer)
        indicatorLayer.frame = CGRect(x: 120, y: 240, width: 100, height: 100)
        indicatorLayer.startAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pulsatorLayer.stopAnimation()
//        indicatorLayer.stopAnimation()
        indicatorLayer.dotCount += 2
        indicatorLayer.dotColor = .red
    }
}
