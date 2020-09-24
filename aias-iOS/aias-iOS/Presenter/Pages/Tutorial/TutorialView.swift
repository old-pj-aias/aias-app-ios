//
//  TutorialView.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/24.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit
import WebKit
import ReusableKit
import RxSwift
import RxCocoa
import PinLayout

final class TutorialView: UIView, UIScrollViewDelegate{
    
    var webView = WKWebView()
    let nextButton = UIButton()
    
    public enum Reusable{
    }
    
    private enum Const {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configWebView()
        addSubview(webView)
        addSubview(nextButton)
        backgroundColor = .white
        webView.scrollView.delegate = self
        layout()
        nextButton.backgroundColor = #colorLiteral(red: 0.2382966185, green: 0.9219939721, blue: 0.4687177609, alpha: 1)
        nextButton.setTitle("Next", for: .normal)
        if let html = Bundle.main.url(forResource: "index", withExtension: "html"){
            webView.loadFileURL(html, allowingReadAccessTo: html)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configWebView(){
        let disableSelectionScriptString = "document.documentElement.style.webkitUserSelect='none';"
        let disableCalloutScriptString = "document.documentElement.style.webkitTouchCallout='none';"

        let disableSelectionScript = WKUserScript(source: disableSelectionScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let disableCalloutScript = WKUserScript(source: disableCalloutScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let controller = WKUserContentController()
        controller.addUserScript(disableSelectionScript)
        controller.addUserScript(disableCalloutScript)

        let wkcfg = WKWebViewConfiguration()
        wkcfg.userContentController = controller
        wkcfg.ignoresViewportScaleLimits = true
        
        webView = WKWebView(frame: webView.frame, configuration: wkcfg)

        if #available(iOS 11.0, *) {
            webView.scrollView.subviews.first?.interactions = []
        }

        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
    }
    
    func layout(){
        webView.pin.top().left().right().bottom(100)
        nextButton.pin.left(35).right(35).height(60).bottom(80)
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
      scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
}


