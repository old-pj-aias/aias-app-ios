//
//  UIViewController+Alert.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/05.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func popAlert(title:String, text: String){
        let alert: UIAlertController = UIAlertController(title: title, message: text, preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}
