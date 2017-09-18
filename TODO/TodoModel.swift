//
//  TodoModel.swift
//  TODO
//

import Foundation
import RealmSwift

class TodoModel: Object {

    dynamic var id = 0
    dynamic var title = ""
    dynamic var detail = "" // city
    dynamic var dateCreated = ""

    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

