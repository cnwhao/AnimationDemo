//
//  ViewController.swift
//  TestAnimation
//
//  Created by William on 2020/9/17.
//  Copyright © 2020 whao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let cellIdentify = "ViewController_UITableViewCell"
    private let dataArray = ["音乐振动条", "波纹-活动指示器"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentify)
    }


}
extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentify)
        }
        cell!.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            let vc = MusicEffectController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = RippleEffectViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}

