
//
//  UserAccount.swift
//  XY微博1
//
//  Created by xuyun on 15/8/3.
//  Copyright © 2015年 xuyun. All rights reserved.
//

import UIKit

class UserAccount: NSObject ,NSCoding{
    
    class var userLogon: Bool {
        return loadAccount() != nil
    }

    //用于调用access_token，接口获取授权后的access token。
    var access_token: String?
    //access_token的生命周期，单位是秒数
    var expires_in: NSTimeInterval = 0
    var expireDate: NSDate?
    //当前授权用户的UID
    var uid: String?
    var avatar_large: String?
    var name: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        expireDate = NSDate(timeIntervalSinceNow: expires_in)
        
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        let properties = ["access_token","expires_in","uid","expireDate"]
        return "\(dictionaryWithValuesForKeys(properties))"
    }
    
    func loadUserInfo() {
        NetworkTools.sharedTools.loadUserInfo(uid!) { (result, error) -> () in
            if error != nil {
                return
            }
            
            self.name = result!["name"] as? String
            self.avatar_large = result!["avatar_large"] as? String
            
            self.saveAccount()
            print(self)
        }
    }
    
    static private let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!.stringByAppendingPathComponent("account.plist")
    
    func saveAccount() {
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
        print(UserAccount.accountPath)
    }
    
    private static var userAccount: UserAccount?
    class func loadAccount() -> UserAccount? {
//        if userAccount == nil {
//            if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount {
//                if account.expireDate?.compare(NSDate()) == NSComparisonResult.OrderedDescending{
//                    return account
//                }
//            }
//        
//        }else{
//            if userAccount!.expireDate?.compare(NSDate()) == NSComparisonResult.OrderedDescending{
//                return userAccount
//            }
//        
//        }
//        
//        return nil
//    }
        if userAccount == nil {
            // 解档 － 如果没有保存过,解档结果可能仍然是 nil
            userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
        }
        
        // 2. 判断日期
        // 测试过期日期
        // userAccount!.expiresDate = NSDate(timeIntervalSinceNow: -100)
        if let date = userAccount?.expireDate where date.compare(NSDate()) == NSComparisonResult.OrderedAscending {
            // 如果已经过期，需要清空账号记录
            userAccount = nil
        }
        
        return userAccount
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expireDate, forKey: "expireDate")
        aCoder.encodeObject(uid, forKey: "uid")
//        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
//        aCoder.encodeObject(name, forKey: "name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        expireDate = aDecoder.decodeObjectForKey("expireDate") as? NSDate
        uid = aDecoder.decodeObjectForKey("uid") as? String
//        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
//        name = aDecoder.decodeObjectForKey("name") as? String
    }
}
