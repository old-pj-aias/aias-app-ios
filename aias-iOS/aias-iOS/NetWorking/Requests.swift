//
//  Requests.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/01.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import RxSwift
import RxAlamofire
import Alamofire

class AiasRequest {
    static let shared = AiasRequest()
    
    private let baseAPIURLString = "http://localhost:8080/"
    
    func request(body: String,path:AiasRequestPath,method:HttpMethods) -> Observable<String>{
        let url = baseAPIURLString + path.rawValue
        var request = URLRequest(url: URL(string: url)!)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return RxAlamofire.requestData(request as URLRequestConvertible).map{ (response, data) -> String in
            String(data: data, encoding: .utf8)!
        }
    }
    
}

enum HttpMethods:String{
    case post = "POST"
    case get = "GET"
}

enum AiasRequestPath:String{
    case ready = "ready"
    case sign = "sign"
    case send_sms = "send_sms"
    case verify_code = "verify_code"
    case auth = "auth"
}
