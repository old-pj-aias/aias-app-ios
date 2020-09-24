//
//  TutorialViewController.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/24.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TutorialViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.nextButton.rx.tap.asObservable().subscribe(onNext: {_ in
            let vc = SMSAuthViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    

   private var mainView: TutorialView {
        self.view as! TutorialView
    }
    
    override func loadView() {
        self.view = TutorialView()
    }

}
