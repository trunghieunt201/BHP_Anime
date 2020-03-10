//
//  ViewController+Extention.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
import JGProgressHUD


extension UIViewController {
    class func loadFromNib() -> Self {
        func loadFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return loadFromNib(self)
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showToast(position: ToastPosition, message: String) {
        var style = ToastStyle.init()
        style.backgroundColor = .black
        style.messageColor = .white
        self.view.makeToast(message, duration: 3.0, position: position, style: style)
    }
    
    func showToastAtBottom(message: String) {
        var style = ToastStyle.init()
        style.backgroundColor = .black
        style.messageColor = .white
        self.view.makeToast(message, duration: 3.0, position: .bottom, style: style)
    }
    
    func showLoading(_ show: Bool) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        if show{
            hud.show(in: self.view)
        }else{
            hud.dismiss()
        }
        
    }
}
