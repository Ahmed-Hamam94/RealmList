//
//  RealmDataBase.swift
//  RealmList
//
//  Created by Ahmed Hamam on 11/02/2023.
//

import Foundation
import RealmSwift
class RealmDataBase {
    static let shared = RealmDataBase()
     var realm = try! Realm()
    
    private init(){
        
    }
    
    func saveInRealm(data: Object){
        try! realm.write({
            realm.add(data)
        })
    }
  
    
    func deleteFromRealm(data: Object){
        try! realm.write({
            realm.delete(data)
        })
    }
    func getCategory() -> Results<Category>{
        return realm.objects(Category.self)
    }
    
    func getRealmPath() {
        print("File Path \(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
    }
}
