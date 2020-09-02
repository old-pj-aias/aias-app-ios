//
//  SMSVerifyView.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/03.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit
import ReusableKit
import RxSwift
import RxCocoa
import PinLayout

final class SMSVerifyView: UIView,UITextFieldDelegate{
    
    let TitleLabel = UILabel()
    let SMSTextField = UITextField()
    let SubmitButton = UIButton()
    
    public enum Reusable{
    }
    
    private enum Const {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(SMSTextField)
        addSubview(SubmitButton)
        
        backgroundColor = .white
        
        SMSTextField.backgroundColor = .white
        SMSTextField.attributedPlaceholder = NSAttributedString(string: "Pin Code", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        SMSTextField.textAlignment = .center
        SMSTextField.keyboardType = .numberPad
        SMSTextField.layer.borderWidth = 1
        
        SubmitButton.backgroundColor = #colorLiteral(red: 1, green: 0.3675946896, blue: 0.5942392387, alpha: 1)
        SubmitButton.setTitle("Verify", for: .normal)
        
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        SMSTextField.pin.left(35).right(35).height(60).vCenter(-120)
        SMSTextField.layer.cornerRadius = SMSTextField.bounds.height/2
        SubmitButton.pin.left(35).right(35).height(60).vCenter(-50)
        SubmitButton.layer.cornerRadius = SubmitButton.bounds.height/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}
