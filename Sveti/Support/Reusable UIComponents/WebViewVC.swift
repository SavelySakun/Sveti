import Foundation
import UIKit
import WebKit

class WebViewVC: BaseViewController {
    private var webView = WKWebView()
    private var url: URL?

    init(urlPath: String) {
        url = URL(string: urlPath)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        webView.navigationDelegate = self
        setWebView()
        setActivityIndicator()
        makeRequest()
    }

    private func setWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func makeRequest() {
        guard let url = url else { return }
        startActivityIndicator()
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewVC: WKNavigationDelegate {
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        startActivityIndicator()
    }

    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        updateLoadingIndicator(show: false)
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
        updateLoadingIndicator(show: false)
    }
}
