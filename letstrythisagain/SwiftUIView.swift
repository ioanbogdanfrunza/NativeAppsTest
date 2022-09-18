import UIKit

class SwiftUIView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
        displayAlert()
    }
    
    func displayAlert() {
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "rahat", message: "basit?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.deleteRecord()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func deleteRecord()
    {
        print("Delete record function called")
    }
    
}
