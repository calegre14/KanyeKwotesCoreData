//
//  CoreDataStack.swift
//  KanyeKwotesCoreData
//
//  Created by Christopher Alegre on 9/26/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {

 static let container: NSPersistentContainer = {

     let container = NSPersistentContainer(name: "KanyeKwotesCoreData")
     container.loadPersistentStores() { (storeDescription, error) in
         if let error = error as NSError? {
             fatalError("Unresolved error \(error), \(error.userInfo)")
         }
     }
     return container
 }()

 static var context: NSManagedObjectContext { return container.viewContext }
}
