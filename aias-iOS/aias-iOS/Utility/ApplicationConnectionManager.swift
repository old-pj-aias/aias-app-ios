//
//  ApplicationConnectionManager.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/02.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import Foundation

class ApplicationConnectionManager {
    static let shared = ApplicationConnectionManager()
    
    var clientInfo = ClientInfo(publicKey: "", appScheme: "")
    var judgeKey = ""
    
    func loadScheme(url:URL){
        let comp = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        let params = urlComponentsToDict(comp: comp!)
        let restoreData = Data(base64Encoded: params["pubkey"] ?? "")
        clientInfo.publicKey = String(data: restoreData!, encoding: .utf8)!
        clientInfo.appScheme = params["scheme"] ?? ""
    }
    
    func encodeScheme(signature:String) -> URL{
        let signatureData = signature.data(using: .utf8)
        let encodedSignature = signatureData?.base64EncodedString()
        let urlString = clientInfo.appScheme + "://" + "aias?signature=" + encodedSignature!
        return URL(string: urlString)!
    }
    
    func urlComponentsToDict(comp:NSURLComponents) -> Dictionary<String, String> {
        var dict:Dictionary<String, String> = Dictionary<String, String>()
        
        for i in 0...(comp.queryItems?.count ?? 0) - 1 {
            let item = comp.queryItems![i] as NSURLQueryItem
            dict[item.name] = item.value
        }
        
        return dict
    }
}

struct ClientInfo {
    var publicKey: String = ""
    var appScheme: String = ""
}
//aias://?pubkey=LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUF4WG8yeldrY2lVRVpCY20vRXhrOApaYWM4Tldza1A1OUVBVkZsTzIxOHhJWE9WMEZmcGhQQi90bmJRaDdHRFhkZG83WFZFcHRIZEhYeUpsWFhMaWhiCjl2WGJVWkYyTkRGTE9oZ0R2N3BhNzJWTkxidytqS1IvRmxzRHR3di9idjdaRHFxK243OXVhdnVKOGdpWDNxQ2YKK210Qm1ybzdoRzVBVnZlM0pJbWh2QTBGdlRLSjB4Q1lVWXcwMnN0MDhIZTVSd0ZBWFFLOEcyY3dhaHArNUVDSApNRGRmRlVhb3hNZlJOLytIbDlpcWlKb3ZLVUpRMzU0NU4yZkRZZGQwZXFTbHFMMU41eEp4WVgxR0RNdEdaZ01FCmhIUjZudGRmbTdyNDNIREI0aGsvTUpJc05heTYrSzl0SkJpejFxWEc0MEc0TmpNS3pWclg5cGkxQnY4RzJSblAKL3dJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t&scheme=aias-demo
