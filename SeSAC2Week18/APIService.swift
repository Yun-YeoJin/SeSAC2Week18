//
//  APIService.swift
//  SeSAC2Week18
//
//  Created by 윤여진 on 2022/11/02.
//

import Foundation
import Alamofire

struct Login: Codable {
    let token: String
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

struct Profile: Codable {
    let user: User
}

class APIService {
    
    func signup() {
        let api = SeSACAPI.signup(userName: "YUN", email: "duwls0349@naver.com", password: "12345678")
        
//        let url = SeSACAPI.signup.url
//        let header: HTTPHeaders = SeSACAPI.signup.header
//        let parameter = SeSACAPI.signup.parameters
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).responseString { response in
            
            print(response)
            print(response.response?.statusCode)
            
        }
        
    }
    
    func login() {
        let api = SeSACAPI.signup(userName: "YUN", email: "duwls0349@naver.com", password: "12345678")
        
//        let url = SeSACAPI.login.url
//        let header: HTTPHeaders = SeSACAPI.login.header
//        let parameter = SeSACAPI.login.parameters
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
                
                switch response.result {
                    
                case .success(let data): //200번대만 성공
                    print(data.token)
                    UserDefaults.standard.set(data.token, forKey: "token")
                    
                case .failure(_): //나머지는 실패
                    print(response.response?.statusCode)
                }
            }
    }
    
    func profile() {
        
        let url = SeSACAPI.profile.url
        let header: HTTPHeaders = SeSACAPI.profile.header
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Profile.self) { response in
                
                switch response.result {
                    
                case .success(let data): //200번대만 성공
                    print(data)
                    
                case .failure(_): //나머지는 실패
                    print(response.response?.statusCode)
                }
                
            }
    }
    
}


