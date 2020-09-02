//
//  MediaSelectManager.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/02.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class QRKeyManager {
    
    var picker: UIImagePickerController! = UIImagePickerController()
    
    func readQR(image: UIImage?) -> String{
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        guard let image = image else { return "" }
        guard let ciImage = CIImage(image: image) else { return "" }
        guard let features = detector?.features(in: ciImage) else { return "" }
        for feature in features as! [CIQRCodeFeature] {
            return feature.messageString!
        }
        return ""
    }
    
}
