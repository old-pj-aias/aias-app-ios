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
    private let disposeBag = DisposeBag()
    
    private var mainView: SMSAuthView {
        self.view as! SMSAuthView
    }
    
    override func loadView() {
        self.view = SMSAuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.SubmitButton.rx.tap.asObservable().subscribe(onNext: {_ in
            AiasRequest.shared.request(body: "{\"phone_number\":\"+81" + String(self.mainView.SMSTextField.text![self.mainView.SMSTextField.text!.index(after: self.mainView.SMSTextField.text!.startIndex)..<self.mainView.SMSTextField.text!.endIndex]) + "\"}", path: .send_sms, method: .post)
                .subscribe(onNext: {text in
                    let vc = SMSVerifyViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

