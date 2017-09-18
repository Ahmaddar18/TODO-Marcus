//
//  MasterTableViewController.swift
//  TODO
//

import UIKit

class MasterTableViewController: UITableViewController, UISearchBarDelegate, UIActionSheetDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView!
    var arrTodoList = NSMutableArray()
    var arrFilter = NSMutableArray()
    var isSearchOpen:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.setEditing(true, animated: true)
        self.navigationItem.title = "Todo List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        arrTodoList = RealmTodoController.getListFromRealm()
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Helper
    
    func actionOpenTodoDetail (selectedTodo: TodoModel)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.objectTodo = selectedTodo
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sortByDate() {
        
        let sortDescriptor = NSSortDescriptor(key: "dateCreated", ascending: false)
        arrTodoList = NSArray(array: arrTodoList).sortedArray(using: [sortDescriptor]) as? Array<TodoModel> as! NSMutableArray
        
        self.tableView.reloadData()
    }
    
    // MARK: - IBAction
    
    @IBAction func actionOpenOptionSheet(_ sender: Any) {
        
        let actionSheet = UIActionSheet(title: "Choose Sort Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Sort by date")
        
        actionSheet.show(in: self.view)
        
    }
    
    // MARK: - ActionSheet Delegate
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        print("\(buttonIndex)")
        switch (buttonIndex){
            
        case 0:
            print("Cancel")
        case 1:
            print("Sort by Date")
            
            self.sortByDate()
            
        default:
            print("Default")
            //Some code here..
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if isSearchOpen {

            return arrFilter.count
        }
        else{
            return arrTodoList.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! TodoCellView

        // Configure the cell...

        let obj : TodoModel
        
        if isSearchOpen {
            
            obj = arrFilter[indexPath.row] as! TodoModel
        }
        else{
            obj = arrTodoList[indexPath.row] as! TodoModel
        }
        
        cell.lblTitle.text = obj.title
        
        cell.lblCity.text = obj.detail
        
        cell.lblDate.text = obj.dateCreated
        
        return cell
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let obj : TodoModel
        
        if isSearchOpen {
            
            obj = arrFilter[indexPath.row] as! TodoModel
        }
        else{
            obj = arrTodoList[indexPath.row] as! TodoModel
        }
        
        actionOpenTodoDetail(selectedTodo: obj)
        
    }
    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let obj = arrTodoList[indexPath.row] as! TodoModel
            
            RealmTodoController.deleteTodoFromRealm(object: obj)
            
            arrTodoList = RealmTodoController.getListFromRealm()
            
            self.tableView.reloadData()
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
     // for Priority
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        swap(&arrTodoList[sourceIndexPath.row],&arrTodoList[destinationIndexPath.row])
    }

    // MARK: - UISearch Methods
    
    
    func filterOrderFromSearchText(searchText: String, newFilterArray: NSMutableArray) -> NSMutableArray {
        
        let predicate = NSPredicate(format: "title contains[c] %@ OR detail contains[c] %@", searchText, searchText)
        
        let resultArray = NSMutableArray(array: newFilterArray).filtered(using: predicate)
        
        return resultArray as! NSMutableArray
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange: String){
        
        print(textDidChange)
        
        arrFilter =  self.filterOrderFromSearchText(searchText: textDidChange, newFilterArray: arrTodoList);
        
        isSearchOpen = false
        
        if(textDidChange.characters.count == 0) {
            isSearchOpen = false
        }else{
            isSearchOpen = true
        }
        
        self.tableView.reloadData()
        
    }
    
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        
        self.searchBar.resignFirstResponder()
        return true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.searchBar.resignFirstResponder()
    }
    
    
}
