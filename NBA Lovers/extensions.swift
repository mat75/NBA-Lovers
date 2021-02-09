//
//  extensions.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 08/02/2021.
//

import Foundation
import UIKit

extension UINavigationController {
    //change the status bar tint
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}
//print json for debug 
extension Data{
    func printJSON(){
        if let JSONString = String(data: self, encoding: String.Encoding.utf8){
            print(JSONString)
        }
    }
}

