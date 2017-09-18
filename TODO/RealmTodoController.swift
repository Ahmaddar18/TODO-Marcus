//
//  RealmTodoController.swift
//  TODO
//

import UIKit
import Foundation
import RealmSwift


class RealmTodoController
{

    class func getListFromRealm() -> NSMutableArray {
        
        let realm = try! Realm()
        
        // Get last todo list
        let listRealm = realm.objects(TodoModel.self)
        
        let arrList = NSMutableArray()
        
        for obj in listRealm {
            arrList.add(obj)
        }
        
        return arrList
    }
    
    class func saveTodoInfoRealm(listObj: TodoModel) {
        
        let realm = try! Realm()
        
        listObj.id = autoIncrementID()
        
        let currentDate = Date()
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let stringFromDate: String = formatter.string(from: currentDate)
        
        listObj.dateCreated = stringFromDate
        
        try! realm.write {
            realm.add(listObj)
        }
        
    }
    
    class func autoIncrementID () -> Int {
        let realm = try! Realm()
        return (realm.objects(TodoModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    class func updateTodoInfoRealm(listObj: TodoModel) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(listObj, update: true)
        }
        
        
    }
    
    class func deleteTodoFromRealm(object: TodoModel){
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
        
    }
   


}
