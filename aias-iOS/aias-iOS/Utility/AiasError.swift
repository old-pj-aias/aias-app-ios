//
//  AiasError.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/03.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import Foundation

enum AiasError: Error{
    case failedToGetAiasToken
    case failedToSaveAiasToken
    case failedToDeleteAiasToken
}
