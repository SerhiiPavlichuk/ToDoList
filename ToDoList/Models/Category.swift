//
//  Category.swift
//  ToDoList
//
//  Created by admin on 28.04.2022.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
