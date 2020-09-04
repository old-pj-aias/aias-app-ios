//
//  KeyChainManager.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/09/03.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import KeychainAccess

final class KeyChainManager {
    
    static let shared = KeyChainManager()
    
    init() {
        var token = ""
        do{
            token = try self.getTokenIfExist()
        }catch{
            token = ""
        }
        self.token = token
    }
    
    var token = ""
    var isExistToken : Bool{
        token != ""
    }
    
    private let keychain = Keychain(service: "com.aias.aias-token")
    
    func updateTokenStatus(){
        
    }
    
    func setToken(token:String) throws{
        do {
            try keychain.set(token, key: "aiasKeyToken")
            self.token = token
        }catch {
            throw AiasError.failedToSaveAiasToken
        }
    }
    
    func deleteToken() throws{
        do {
            try keychain.remove("aiasKeyToken")
            self.token = ""
        }catch {
            throw AiasError.failedToDeleteAiasToken
        }
    }
    
    func getTokenIfExist() throws -> String{
        let token = try? keychain.getString("aiasKeyToken")
        if let token = token{
            return token
        }else{
            throw AiasError.failedToGetAiasToken
        }
    }
    
}
