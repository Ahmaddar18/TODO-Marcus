//
//  AddViewController.swift
//  TODO
//

import UIKit

import RealmSwift

class AddViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions Methods
    
    @IBAction func onDoneClick(_ sender: Any) {
        
        if tfTitle.text?.characters.count == 0 || tfCity.text?.characters.count == 0  {
            return
        }
        
        let obj = TodoModel()
        obj.title = (tfTitle?.text)!
        obj.detail = (tfCity?.text)!
        
        RealmTodoController.saveTodoInfoRealm(listObj: obj)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }

    

}
