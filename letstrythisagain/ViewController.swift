import UIKit
import WebKit

class ViewController: UIViewController {
    
    let webView : WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero,
                                configuration: configuration)
        
        return webView
    }()
    
    private let floatingButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = .systemBlue
        let image = UIImage(systemName: "arrowshape.turn.up.right",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        //Corner radius
        button.layer.cornerRadius = 30
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(webView, at: 0)
        view.insertSubview(floatingButton, at: 1)
        
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        guard let url = URL(string: "https://www.winmasters.gr") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        floatingButton.frame = CGRect(x: view.frame.size.width - 70 ,
                                       y: view.frame.size.height - 120 ,
                                       width: 60,
                                       height: 60)
    }
    
    
    @IBAction func didTapButton() {
        present(ApiCallView(), animated: true)
    }
}






