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
    private let pickerView: UIPickerView = UIPickerView()
    
    let selectedEJkey = BehaviorRelay<String>(value: "")
    
    private var mainView: SMSAuthView {
        self.view as! SMSAuthView
    }
    
    override func loadView() {
        self.view = SMSAuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        mainView.SelectEJkeyTextField.inputView = pickerView
        mainView.SelectEJkeyTextField.inputAccessoryView = toolBar
        
        Observable.just(EJkeys().keys + [EJkey(name: "Read EJ key from QR", key: "")]).bind(to: pickerView.rx.itemTitles) { (row, element) in
            return element.name
        }
        .disposed(by: disposeBag)
        
        pickerView.rx.itemSelected
            .subscribe { (event) in
                switch event {
                case .next(let selected):
                    if selected.row == EJkeys().keys.count{
                        self.mainView.SelectEJkeyTextField.text = "Read EJ key from QR"
                    }else{
                        self.mainView.SelectEJkeyTextField.text = EJkeys().keys[selected.row].name
                        self.selectedEJkey.accept(EJkeys().keys[selected.row].key)
                    }
                default:
                    break
                }
        }
        .disposed(by: disposeBag)
        
        //        let sm = SignatureManager()
        //        sm.setSubset(signerKey: key, judgeKey: key, text: "ttt").subscribe(onNext: {
        //            sm.GenerateSignature().subscribe(onNext: { st in
        //                print(st)
        //            }).disposed(by: self.disposeBag)
        //        }).disposed(by: disposeBag)
    }
    
    @objc private func donePicker() {
        mainView.SelectEJkeyTextField.resignFirstResponder()
        //if EJkey from QR is selected, call photo library
        if self.mainView.SelectEJkeyTextField.text == "Read EJ key from QR"{
            
        }
        
    }
    
}

