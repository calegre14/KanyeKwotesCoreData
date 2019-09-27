//
//  Kwote+Con.swift
//  KanyeKwotesCoreData
//
//  Created by Christopher Alegre on 9/26/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import Foundation
import CoreData

extension Knote {
    
    convenience init(body: String, isKanye: Bool, notKayneName: String = "", context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.body = body
        self.isKanye = isKanye
        self.notKayneName = notKayneName
        self.vailed = true
        
    }
}
