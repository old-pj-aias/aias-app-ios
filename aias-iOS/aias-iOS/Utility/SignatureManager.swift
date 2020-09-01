//
//  SignatureManager.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/01.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import RxSwift
import RxAlamofire
import Foundation

class SignatureManager {
    
    func setSubset(signerKey:String,judgeKey:String,text:String) -> Observable<Void>{
        new_ios(signerKey, judgeKey)
        let blindedDigest = String(cString: blind_ios(text))
        return AiasRequest.shared.request(body: blindedDigest, path: .ready)
            .map{subset -> () in
                set_subset_ios(subset)
        }
    }
    
    func GenerateSignature() -> Observable<String>{
        let checkParam = String(cString: generate_check_parameter_ios())
        return AiasRequest.shared.request(body: checkParam, path: .sign)
            .map{blindSignature -> String in
                String(cString: unblind_ios(blindSignature))
        }
    }
    
}
