//
//  ListItem+CoreDataProperties.swift
//  ListOfLists
//
//  Created by Nash Vail on 11/06/16.
//  Copyright © 2016 Nishant Verma ( Nash Vail ). All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ListItem {

    @NSManaged var value: String?
    @NSManaged var list: List?

}
