//
//  ReadyView.swift
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

final class ReadyView: UIView{
    
    let TitleLabel = UILabel()
    let LogoutButton = UIButton()
    
    public enum Reusable{
    }
    
    private enum Const {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(TitleLabel)
        addSubview(LogoutButton)
        
        backgroundColor = .white
        
        TitleLabel.text = "Ready to use aias app."
        TitleLabel.textAlignment = .center
        
        LogoutButton.backgroundColor = #colorLiteral(red: 1, green: 0.2471628109, blue: 0.1646957157, alpha: 1)
        LogoutButton.setTitle("Logout", for: .normal)
        
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        TitleLabel.pin.left(35).right(35).height(60).vCenter(-120)
        TitleLabel.layer.cornerRadius = TitleLabel.bounds.height/2
        LogoutButton.pin.left(35).right(35).height(60).vCenter(-50)
        LogoutButton.layer.cornerRadius = LogoutButton.bounds.height/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

