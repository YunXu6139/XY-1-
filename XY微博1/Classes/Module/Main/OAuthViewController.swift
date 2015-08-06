//
//  OAuthViewController.swift
//  XY微博1
//
//  Created by xuyun on 15/8/1.
//  Copyright © 2015年 xuyun. All rights reserved.
//

import UIKit
import SVProgressHUD
class OAuthViewController: UIViewController, UIWebViewDelegate {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        title = "新浪微博"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        webView.delegate = self
        
    }
    
    func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(NSURLRequest(URL: NetworkTools.sharedTools.oauthUrl()))
        
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let urlString = request.URL!.absoluteString
        if !urlString.hasPrefix(NetworkTools.sharedTools.redirectUri) {
            return true
        }
    
        if let query = request.URL?.query where query.hasPrefix("code=") {
            let code = query.substringFromIndex(advance(query.startIndex, "code=".characters.count))
            //换取TOKEN
            loadAccessToken(code)
        }else{
            close()
        }
        
        return false
    }
    
    private func loadAccessToken(code: String) {
        NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
            if error != nil || result == nil {
                SVProgressHUD.showInfoWithStatus("您的网络不给力")
                let when = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC))
                dispatch_after(when, dispatch_get_main_queue(), { () -> Void in
                    self.close()
                })
                return
            }
            
            //字典转模型
            UserAccount(dict: result!).loadUserInfo()
           
           
        }
    
    }
    
    
   
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    
    
    
    }


   
}
