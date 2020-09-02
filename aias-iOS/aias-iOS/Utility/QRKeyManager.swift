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

final class ImageManager {
    func pickMediaPhoto(vc:UIViewController){
        return UIImagePickerController.rx.createWithParent { picker in
            picker.sourceType = type
            picker.allowsEditing = true
        }
        .flatMap { $0.rx.didFinishPickingMediaWithInfo }
        .take(1)
        .map { info in return info[UIImagePickerControllerOriginalImage] as? UIImage }
    }
}
