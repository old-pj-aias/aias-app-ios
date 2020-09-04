//
//  ClientAuthView.swift
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

final class ClientAuthView: UIView,UITextFieldDelegate{
    
    let SelectEJkeyTextField = UITextField()
    let SubmitButton = UIButton()
    let explainLabel = UILabel()
    
    public enum Reusable{
    }
    
    private enum Const {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(explainLabel)
        addSubview(SelectEJkeyTextField)
        addSubview(SubmitButton)
        
        backgroundColor = .white
        
        explainLabel.text = "Please select judges. \nYou will be tracked when the judges are unanimous."
        explainLabel.font = UIFont.systemFont(ofSize: 13)
        explainLabel.numberOfLines = 3
        
        SelectEJkeyTextField.layer.borderWidth = 1
        SelectEJkeyTextField.attributedPlaceholder = NSAttributedString(string: "EJ Key", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        SelectEJkeyTextField.textAlignment = .center
        SelectEJkeyTextField.tintColor = .clear
        
        SubmitButton.backgroundColor = #colorLiteral(red: 1, green: 0.3675946896, blue: 0.5942392387, alpha: 1)
        SubmitButton.setTitle("Select EJ Key", for: .normal)
        
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        SelectEJkeyTextField.pin.left(35).right(35).height(60).vCenter(-120)
        SelectEJkeyTextField.layer.cornerRadius = SelectEJkeyTextField.bounds.height/2
        explainLabel.pin.left(35).right(35).height(55).bottom(to: SelectEJkeyTextField.edge.top).marginBottom(10)
        SubmitButton.pin.left(35).right(35).height(60).vCenter(-50)
        SubmitButton.layer.cornerRadius = SubmitButton.bounds.height/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}
