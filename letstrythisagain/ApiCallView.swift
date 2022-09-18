import UIKit

class ApiCallView: UIViewController {
    
    var errorType = ""
    var alertMessage = ""
    
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = .systemRed
        let image = UIImage(systemName: "homekit",
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
        self.view.backgroundColor = UIColor.white
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.insertSubview(floatingButton, at: 1)
        let url = "https://gamelaunch-stage.everymatrix.com/Loader/Start/2237/wolfgold?casinolobbyurl=https%3A%2F%2Fgames.staging.irl.aws.tipicodev.de%2Fen%2F&funMode=False&language=en&launchApi=true&_sid64=R3fJpfl4GwmcsDzrNpvOyS1YEGM4agCkwxB.kjbzBzZZkbyfU0_GGg--#"
        getData(from: url)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
        displayAlert()
    }
    
    private func getData(from url: String) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong!")
                return
            }
            var result: ApiData?
            do {
                result = try JSONDecoder().decode(ApiData.self, from: data)
                
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            var errorMessage = json.ErrorMessage
            self.errorType = json.ErrorType
            var requestId = json.RequestId
            var timeStamp = json.TimeStamp
            self.alertMessage = errorMessage + " " + requestId + " " + timeStamp
            
            
        })
        
        task.resume()
        
    }
    
    func displayAlert() {
        let dialogMessage = UIAlertController(title: errorType, message: alertMessage, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.deleteRecord()
        })
        
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func deleteRecord()
    {
        print("Delete record function called")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 70 ,
                                       y: view.frame.size.height - 120 ,
                                       width: 60,
                                       height: 60)
    }
    
    @IBAction func didTapButton() {
        present(ViewController(), animated: true)
    }
    
    
   
    }




struct ApiData: Decodable {
    let ErrorMessage: String
    let ErrorType: String
    let RequestId: String
    let TimeStamp: String
}

