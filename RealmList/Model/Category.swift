//
//  Category.swift
//  RealmList
//
//  Created by Ahmed Hamam on 11/02/2023.
//

import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var title : String = ""
    let items = List<Item>()
}
