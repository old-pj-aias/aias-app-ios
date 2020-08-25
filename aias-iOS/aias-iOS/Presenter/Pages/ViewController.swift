//
//  ViewController.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/08/25.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(sayHello(to:"randtest"))
    }

    func sayHello(to: String) -> String {
        let result = rust_greeting(to)
        let swift_result = String(cString: result!)
        rust_greeting_free(UnsafeMutablePointer(mutating: result))
        return swift_result
    }

}

