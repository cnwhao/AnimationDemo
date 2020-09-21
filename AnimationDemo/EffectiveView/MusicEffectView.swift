//
//  MusicEffectView.swift
//  TestAnimation
//  音乐振动条
//  Created by William on 2020/9/21.
//  Copyright © 2020 whao. All rights reserved.
//

import UIKit

class MusicEffectView: UIView {
    private weak var delegate:MusicEffectViewProtocol!
    private let shapLayer = CAShapeLayer()
    private let replicatorLayer = CAReplicatorLayer()
    init(effectDelegate: MusicEffectViewProtocol) {
        delegate = effectDelegate
        super.init(frame: .zero)
        self.backgroundColor = UIColor.black
        let layer1 = shapLayer
        self.layer.addSublayer(layer1)
        let layer2 = replicatorLayer
        layer2.instanceDelay = delegate.effectDuration(at: self) / Double(delegate.columnNumber(at: self))
        layer2.addSublayer(layer1)
        self.layer.addSublayer(layer2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reSizeUI()
    }
    private func reSizeUI() {
        let layer1 = shapLayer
        let columnCount = CGFloat(delegate.columnNumber(at: self))
        let itemWidth = delegate.columnWidth(at: self)
        let itemSpace = delegate.columnSpace(at: self)
        var offsetX:CGFloat = 0
        if columnCount < 2 {
            offsetX = (self.bounds.size.width - itemWidth) * 0.5
        } else {
            offsetX = (self.bounds.size.width - (itemWidth + itemSpace) * columnCount + itemSpace) * 0.5
        }
        
        let rect = CGRect(x: offsetX, y: 0, width: itemWidth, height: delegate.columnMaxHeight(at: self))
        var bezier:UIBezierPath?
        if delegate.effectHasCorners(at: self) {
            bezier = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: itemWidth * 0.5, height: itemWidth * 0.5))
        } else {
            bezier = UIBezierPath(rect: rect)
        }
        layer1.path = bezier?.cgPath
        layer1.fillColor = delegate.columnColor(at: self).cgColor
        
        let layer2 = replicatorLayer
        layer2.instanceTransform = CATransform3DMakeTranslation(delegate.columnWidth(at: self) + delegate.columnSpace(at: self), 0, 0)
        layer2.instanceCount = delegate.columnNumber(at: self)
        
        layer1.removeAnimation(forKey: effectAnimationKey)
        layer1.add(effectAnimation, forKey: effectAnimationKey)
    }
    private let effectAnimationKey = "effectAnimationKey"
    private var effectAnimation:CABasicAnimation {
        get {
            let offsetY = delegate.columnMaxHeight(at: self) - delegate.columnMinHeight(at: self) + self.shapLayer.frame.size.height * 0.5
            let ani = CABasicAnimation(keyPath: "position")
            ani.fromValue = self.shapLayer.position
            ani.toValue = CGPoint(x: self.shapLayer.position.x, y: offsetY)
            ani.duration = self.delegate.effectDuration(at: self)
            ani.autoreverses = true
            ani.repeatCount = MAXFLOAT
            ani.isRemovedOnCompletion = false
            return ani
        }
    }
}

protocol MusicEffectViewProtocol where Self:NSObject {
    func effectDuration(at effectView:MusicEffectView) -> TimeInterval
    func effectHasCorners(at effectView:MusicEffectView) -> Bool
    func columnNumber(at effectView:MusicEffectView) -> Int
    func columnColor(at effectView:MusicEffectView) -> UIColor
    func columnSpace(at effectView:MusicEffectView) -> CGFloat
    func columnWidth(at effectView:MusicEffectView) -> CGFloat
    func columnMinHeight(at effectView:MusicEffectView) -> CGFloat
    func columnMaxHeight(at effectView:MusicEffectView) -> CGFloat
}

extension MusicEffectViewProtocol {
    func effectHasCorners(at effectView:MusicEffectView) -> Bool {
        return true
    }
    func effectDuration(at effectView:MusicEffectView) -> TimeInterval {
        return 1
    }
    func columnNumber(at effectView:MusicEffectView) -> Int {
        return 5
    }
    func columnColor(at effectView:MusicEffectView) -> UIColor {
        return UIColor.white
    }
    func columnSpace(at effectView:MusicEffectView) -> CGFloat {
        return self.columnWidth(at: effectView) * 0.5
    }
    func columnWidth(at effectView:MusicEffectView) -> CGFloat {
        if effectView.bounds.size.width > 0 {
            let column = self.columnNumber(at: effectView)
            let asColumns = CGFloat(column - 1)/2.0 + CGFloat(column)
            return effectView.bounds.size.width / asColumns
        }
        return 5
    }
    func columnMinHeight(at effectView:MusicEffectView) -> CGFloat {
        return 5
    }
    func columnMaxHeight(at effectView:MusicEffectView) -> CGFloat {
        if effectView.bounds.size.height > 0 {
            return effectView.bounds.size.height
        }
        return 20
    }
}
