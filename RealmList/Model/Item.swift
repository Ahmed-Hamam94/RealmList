//
//  Item.swift
//  RealmList
//
//  Created by Ahmed Hamam on 11/02/2023.
//

import Foundation
import RealmSwift
class Item : Object{
    @objc dynamic var title : String = ""
    @objc dynamic var checked : Bool = false
    let parent = LinkingObjects(fromType: Category.self, property: "items")
    
    convenience init(title: String, checked: Bool) {
          self.init()
          self.title = title
          self.checked = checked
      }
}
