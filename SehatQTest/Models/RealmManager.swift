//
//  RealmManager.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import Foundation
import RealmSwift
import Realm

class RealmManager: NSObject {
    let realm = try! Realm()
    static let shared = RealmManager()
    
    var dataHomeModel: Results<DataHomeModel>?
    var orderItem: Results<OrderItemModel>?
    
    // MARK: - READ/LOAD OBJECT
    func loadRealmObject() {
        dataHomeModel = realm.objects(DataHomeModel.self)
        orderItem = realm.objects(OrderItemModel.self)
    }
    
    func retrieveAllDataForObject(_ T : Object.Type) -> [Object] {
        
        var objects = [Object]()
        for result in realm.objects(T) {
            objects.append(result)
        }
        return objects
    }
    
    func deleteAllDataForObject(_ T : Object.Type) {
        
        self.delete(self.retrieveAllDataForObject(T))
    }
    
    func replaceAllDataForObject(_ T : Object.Type, with objects : [Object]) {
        
        deleteAllDataForObject(T)
        add(objects)
    }
    
    func add(_ objects : [Object], completion : @escaping() -> ()) {
        
        try! realm.write{
            
            realm.add(objects)
            completion()
        }
    }
    
    func add(_ objects : [Object]) {
        
        try! realm.write{
            
            realm.add(objects)
        }
    }
    
    func add(_ objects : Object) {
        
        try! realm.write{
            
            realm.add(objects)
        }
    }
    
    func update(_ block: @escaping ()->Void) {
        
        try! realm.write(block)
    }
    
    func delete(_ objects : [Object]) {
        
        try! realm.write{
            realm.delete(objects)
        }
    }
    
    func delete(_ objects : Object) {
        
        try! realm.write{
            realm.delete(objects)
        }
    }
}
