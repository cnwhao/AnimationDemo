//
//  MusicEffectController.swift
//  TestAnimation
//
//  Created by William on 2020/9/17.
//  Copyright © 2020 whao. All rights reserved.
//

import UIKit

class MusicEffectController: UIViewController {
    private var musicView1:MusicEffectView?
    private var musicView2:MusicEffectView?
    private var musicView3:MusicEffectView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
        musicView1 = MusicEffectView(effectDelegate: self)
        self.view.addSubview(musicView1!)
        musicView1!.frame = CGRect(x: 80, y: 100, width: 100, height: 100)
        
        musicView2 = MusicEffectView(effectDelegate: self)
        musicView2?.clipsToBounds = true
        self.view.addSubview(musicView2!)
        musicView2!.frame = CGRect(x: 80, y: 260, width: 220, height: 120)
        
        musicView3 = MusicEffectView(effectDelegate: self)
        self.view.addSubview(musicView3!)
        musicView3!.frame = CGRect(x: 80, y: 440, width: 220, height: 120)
    }
}

extension MusicEffectController:MusicEffectViewProtocol {
    func effectHasCorners(at effectView: MusicEffectView) -> Bool {
        if effectView == musicView2 {
            return false
        }
        return true
    }
}
