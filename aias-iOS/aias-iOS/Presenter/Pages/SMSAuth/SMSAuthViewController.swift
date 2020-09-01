//
//  SMSAuthViewController.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/08/25.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SMSAuthViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    private var mainView: SMSAuthView {
        self.view as! SMSAuthView
    }
    
    override func loadView() {
        self.view = SMSAuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

