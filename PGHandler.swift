//
//  PGHandler.swift
//
//  Created by Mujun Kim on 2020/11/22.
//

import WebKit

public class PGHandler {
    
    public enum Result { case shouldCancel, shouldAllow, appNotInstalled }
    
    private init() { }
    
    public class func handle(action: WKNavigationAction) -> Result {
        guard let url = action.request.url else { return .shouldAllow }
        
        if url.scheme == "itms-apps" || url.host == "itunes.apple.com" || url.host == "apps.apple.com" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                return .shouldCancel
            }
        }
        
        if url.scheme != "http" && url.scheme != "https" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                return .shouldCancel
            } else {
                return .appNotInstalled
            }
        }
        
        return .shouldAllow
    }
    
}
