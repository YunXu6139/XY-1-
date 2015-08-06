//
//  NetworkTools.swift
//  XY微博1
//
//  Created by xuyun on 15/8/1.
//  Copyright © 2015年 xuyun. All rights reserved.
//

import UIKit
import AFNetworking

private let XYErrorDomainName = "com.itheima.error.network"

class NetworkTools: AFHTTPSessionManager {
    
    
    private let clientId = "3968271176"
    private let appSecret = "55125205a8e70fafc40742ffd14b6843"
    let redirectUri = "http://www.baidu.com"

    static let sharedTools: NetworkTools = {
        let baseUrl = NSURL(string: "https://api.weibo.com/")!
        let tools = NetworkTools(baseURL: baseUrl)
        tools.responseSerializer.acceptableContentTypes = NSSet(objects:"application/xml", "text/xml", "text/plain") as Set<NSObject>
        
        return tools
    }()
    
    //MARK: - 加载用户数据
    func loadUserInfo(uid: String,finished: XYNetFinishedCallBack) {
        if UserAccount.loadAccount()?.access_token == nil {
            return
        }
        let urlString = "2/users/domain_show.json"
        let params: [String: AnyObject] = ["access_token": UserAccount.loadAccount()!.access_token!, "uid": uid]
        requestGet(urlString, params: params, finished: finished)
    }
    
    
    func oauthUrl() -> NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(clientId)&redirect_uri=\(redirectUri)"
        return NSURL(string: urlString)!
    }

    //加载token
    func loadAccessToken(code: String, finished: XYNetFinishedCallBack) {
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":clientId,
            "client_secret":appSecret,
            "grant_type":"authorization_code",
            "code":code,
            "redirect_uri":redirectUri]
        POST(urlStr, parameters: params, success: { (_, JSON) -> Void in
                print(JSON)
            finished(result: JSON as? [String: AnyObject], error: nil)
            }) { (_, error) -> Void in
                print(error)
                finished(result: nil, error: error)
        }
    
    
    }
    //MARK: - 封装AFN网络方法
    typealias XYNetFinishedCallBack = (result: [String: AnyObject]?, error: NSError?)->()
    private func requestGet(urlString: String, params: [String: AnyObject], finished: XYNetFinishedCallBack) {
        GET(urlString, parameters: params, success: { (_, JSON) -> Void in
            if let result = JSON as? [String: AnyObject] {
                finished(result: result, error: nil)
            }else{
                print("没有数据")
               let error = NSError(domain: XYErrorDomainName, code: -1, userInfo: ["errorMessage":"空数据"])
                finished(result: nil, error: error)
            }
            }) { (_, error) -> Void in
                finished(result: nil, error: error)
        }
    
    }
    
}
