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
    
    func setSubset(judgeKey:String,text:String,id:Int) -> Observable<Void>{
        new_ios(EJkeys().sinerKey, judgeKey,UInt32(id))
        let blindedDigest = String(cString: generate_ready_parameter_ios(text,judgeKey))
        return AiasRequest.shared.request(body: blindedDigest, path: .ready, method: .post)
            .map{subset -> () in
                set_subset_ios(subset)
        }
    }
    
    func GenerateSignature() -> Observable<String>{
        let checkParam = String(cString: generate_check_parameter_ios())
        return AiasRequest.shared.request(body: checkParam, path: .sign, method: .post)
            .map{blindSignature -> String in
                String(cString: unblind_ios(blindSignature))
        }
    }
    
}
