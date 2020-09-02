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
    func pickMediaPhoto(vc:UIViewController) -> Observable<UIImage?>{
        return UIImagePickerController.rx.createWithParent(vc) { picker in
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
        }
        .flatMap { $0.rx.didFinishPickingMediaWithInfo }
        .take(1)
        .map { info in
            return info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        }
    }
}
