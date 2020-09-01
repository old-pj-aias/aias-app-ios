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
        let key =
"""
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxXo2zWkciUEZBcm/Exk8
Zac8NWskP59EAVFlO218xIXOV0FfphPB/tnbQh7GDXddo7XVEptHdHXyJlXXLihb
9vXbUZF2NDFLOhgDv7pa72VNLbw+jKR/FlsDtwv/bv7ZDqq+n79uavuJ8giX3qCf
+mtBmro7hG5AVve3JImhvA0FvTKJ0xCYUYw02st08He5RwFAXQK8G2cwahp+5ECH
MDdfFUaoxMfRN/+Hl9iqiJovKUJQ3545N2fDYdd0eqSlqL1N5xJxYX1GDMtGZgME
hHR6ntdfm7r43HDB4hk/MJIsNay6+K9tJBiz1qXG40G4NjMKzVrX9pi1Bv8G2RnP
/wIDAQAB
-----END PUBLIC KEY-----
"""
        let sm = SignatureManager()
        sm.setSubset(signerKey: key, judgeKey: key, text: "ttt").subscribe(onNext: {
            sm.GenerateSignature().subscribe(onNext: { st in
                print(st)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
}

