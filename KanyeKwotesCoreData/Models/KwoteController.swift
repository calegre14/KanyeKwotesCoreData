//
//  KwoteController.swift
//  KanyeKwotesCoreData
//
//  Created by Christopher Alegre on 9/26/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import Foundation
import CoreData

class KwoteController {
    
    static let shared = KwoteController()
    
    var fetchResultsController: NSFetchedResultsController<Knote>
    init() {
        let request: NSFetchRequest<Knote> = Knote.fetchRequest()
        let isVailed = NSSortDescriptor(key: "vailed", ascending: false)
        request.sortDescriptors = [isVailed]
        
        let bigDaddyController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController = bigDaddyController
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func add(body: String, isKanye: Bool, notKayneName: String = ""){
        let newKnote = Knote(body: body, isKanye: isKanye)
        if !notKayneName.isEmpty {
            newKnote.notKayneName = notKayneName
        }
        saveToPersistantStorage()
    }
    
    func update(knote: Knote, body: String, isKanye: Bool, notKayneName: String) {
        knote.body = body
        knote.isKanye = isKanye
        knote.notKayneName = notKayneName
        saveToPersistantStorage()
        
    }
    
    func delete(knote: Knote) {
        CoreDataStack.context.delete(knote)
        saveToPersistantStorage()
    }
    
    func toggle(knote: Knote) {
        knote.vailed.toggle()
        saveToPersistantStorage()
    }
    
    func saveToPersistantStorage() {
        if CoreDataStack.context.hasChanges {
            try? CoreDataStack.context.save()
        }
    }
    
}

