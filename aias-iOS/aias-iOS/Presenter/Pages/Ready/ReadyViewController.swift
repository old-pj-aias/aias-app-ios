//
//  ReadyViewController.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/03.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


final class ReadyViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.LogoutButton.rx.tap.asObservable().subscribe(onNext: {_ in
            do{
                try KeyChainManager.shared.deleteToken()
                let appDelegate  = UIApplication.shared.delegate
                appDelegate?.window!?.rootViewController = SMSAuthViewController()
            }catch{
                print("aa")
            }
        }).disposed(by: disposeBag)
    }
    
    private var mainView: ReadyView {
        self.view as! ReadyView
    }
    
    override func loadView() {
        self.view = ReadyView()
    }
    
    
    
}
