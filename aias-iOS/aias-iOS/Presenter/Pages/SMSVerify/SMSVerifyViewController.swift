//
//  SMSVerifyViewController.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/03.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SMSVerifyViewController: UIViewController{
    private let disposeBag = DisposeBag()
    private let pickerView: UIPickerView = UIPickerView()
    private var picker: UIImagePickerController! = UIImagePickerController()
    
    let selectedEJkey = BehaviorRelay<String>(value: "")
    
    private var mainView: SMSVerifyView {
        self.view as! SMSVerifyView
    }
    
    override func loadView() {
        self.view = SMSVerifyView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.SubmitButton.rx.tap.asObservable().subscribe(onNext: {_ in
            AiasRequest.shared.request(body: "{\"code\":" + self.mainView.SMSTextField.text! + "}", path: .verify_code, method: .post)
                .subscribe(onNext: {tokenResponse in
                    if let token = (tokenResponse.convertToDictionary()?["token"] as? String){
                        do{
                            try KeyChainManager().setToken(token: token)
                        }catch{
                            print("aa")
                        }
                    }else{
                        //failed to get token
                    }
                    
//                    let id = text.convertToDictionary()?["id"] as? Int ?? 0
//                    let sm = SignatureManager()
//                    sm.setSubset(judgeKey: ApplicationConnectionManager.shared.judgeKey, text: ApplicationConnectionManager.shared.clientInfo.publicKey, id: id).subscribe(onNext: {
//                        sm.GenerateSignature().subscribe(onNext: { signature in
//                            let clientAppURL = ApplicationConnectionManager.shared.encodeScheme(signature: signature)
//                            if UIApplication.shared.canOpenURL(clientAppURL)
//                            {
//                                UIApplication.shared.open(clientAppURL, options: [:], completionHandler: nil)
//                            }
//                        }).disposed(by: self.disposeBag)
//                    }).disposed(by: self.disposeBag)
                }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

