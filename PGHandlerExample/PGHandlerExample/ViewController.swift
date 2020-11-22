//
//  ViewController.swift
//  PGHandlerExample
//
//  Created by Mujun Kim on 2020/11/22.
//

import UIKit
import WebKit

final class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let req = URLRequest(url: URL(string: "https://www.iamport.kr/demo")!)
        webView.load(req)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { _ in completionHandler() })
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        switch PGHandler.handle(navigationAction: navigationAction) {
        case .shouldCancel:
            decisionHandler(.cancel)
        case .shouldAllow:
            decisionHandler(.allow)
        case .appNotInstalled:
            webView.evaluateJavaScript("alert('앱이 설치되지 않았습니다.')")
            decisionHandler(.cancel)
        }
    }

}
