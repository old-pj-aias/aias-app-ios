//
//  Requests.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/01.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import Foundation

class AiasRequest {
    private let baseAPIURLString = "localhost:8080"
}

fileprivate enum AiasRequestPath:String{
    case ready = "ready"
    case sign = "sign"
}
