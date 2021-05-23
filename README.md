# PGHandler

[![License](https://img.shields.io/github/license/mznu/PGHandler)](http://www.wtfpl.net/)

`WKWebView` 를 사용하는 iOS 9+ 하이브리드 앱용 PG 연동 Helper

## 사용법

1. `info.plist` 에 `LSApplicationQueriesSchemes` 추가 (`schemes.xml` 에서 복사)
2. `PGHandler.swift` 를 프로젝트에 추가
3. `WKNavigationDelegate` 의 `webView(_:decidePolicyFor:decisionHandler:)` 구현

```swift
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    switch PGHandler.handle(action: navigationAction) {
    case .shouldCancel:
        decisionHandler(.cancel)
    case .shouldAllow:
        decisionHandler(.allow)
    case .appNotInstalled:
        webView.evaluateJavaScript("alert('앱이 설치되지 않았습니다.')")
        decisionHandler(.cancel)
    }
}
```
