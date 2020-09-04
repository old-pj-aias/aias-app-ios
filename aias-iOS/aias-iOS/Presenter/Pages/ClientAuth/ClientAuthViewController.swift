//
//  ClientAuthViewController.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/03.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ClientAuthViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let disposeBag = DisposeBag()
    private let pickerView: UIPickerView = UIPickerView()
    private var picker: UIImagePickerController! = UIImagePickerController()
    
    let selectedEJkey = BehaviorRelay<String>(value: "")
    
    private var mainView: ClientAuthView {
        self.view as! ClientAuthView
    }
    
    override func loadView() {
        self.view = ClientAuthView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !KeyChainManager.shared.isExistToken{
            let vc = SMSAuthViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
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
        
        selectedEJkey.subscribe(onNext: { string in
            ApplicationConnectionManager.shared.judgeKey = string
            if self.mainView.SelectEJkeyTextField.text == "Read EJ key from QR"{
                self.mainView.SelectEJkeyTextField.text = "Loaded EJ key from QR"
            }
        }).disposed(by: disposeBag)
        
        mainView.SubmitButton.rx.tap.asObservable().subscribe(onNext: {_ in
            print("{\"token\":\"" + KeyChainManager.shared.token + "\"}")
            AiasRequest.shared.request(body: "{\"token\":\"" + KeyChainManager.shared.token + "\"}", path: .auth, method: .post)
            .subscribe(onNext: {idResponse in
                if let id = (idResponse.convertToDictionary()?["id"] as? Int){
                    let sm = SignatureManager()
                    sm.setSubset(judgeKey: ApplicationConnectionManager.shared.judgeKey, text: ApplicationConnectionManager.shared.clientInfo.publicKey, id: id).subscribe(onNext: {
                        sm.GenerateSignature().subscribe(onNext: { signature in
                            let clientAppURL = ApplicationConnectionManager.shared.encodeScheme(signature: signature)
                            UIApplication.shared.open(clientAppURL, options: [:], completionHandler: { _ in
                                let appDelegate  = UIApplication.shared.delegate
                                appDelegate?.window!?.rootViewController = ReadyViewController()
                            })
                        }).disposed(by: self.disposeBag)
                    }).disposed(by: self.disposeBag)
                }else{
                    //failed to get token
                }
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)
        
        
    }
    
    @objc private func donePicker() {
        mainView.SelectEJkeyTextField.resignFirstResponder()
        //if EJkey from QR is selected, call photo library
        if self.mainView.SelectEJkeyTextField.text == "Read EJ key from QR"{
            pickImage()
        }
        
    }
    
    func pickImage(){
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.navigationBar.tintColor = UIColor.white
        picker.navigationBar.barTintColor = UIColor.gray
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let pubKey = QRKeyManager().readQR(image: image)
            selectedEJkey.accept(pubKey)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

