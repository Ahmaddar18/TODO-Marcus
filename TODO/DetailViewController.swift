//
//  DetailViewController.swift
//  TODO
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    
    
    var button = UIButton()
    
    var objectTodo : TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        self.navigationItem.title = "Update Todo"
        
        setScreenDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Helper
    
    
    func setScreenDate() {
        
        tfTitle.text = objectTodo?.title
        tfCity.text = objectTodo?.detail
        
    }
    
    @IBAction func actionUpdateInfo(_ sender: Any) {
        
        if tfTitle.text?.characters.count == 0 || tfCity.text?.characters.count == 0  {
            return
        }
        
        let obj = TodoModel()
        obj.id = (objectTodo?.id)!
        obj.dateCreated = (objectTodo?.dateCreated)!
        
        obj.title = (tfTitle?.text)!
        obj.detail = (tfCity?.text)!
        
        RealmTodoController.updateTodoInfoRealm(listObj: obj)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
