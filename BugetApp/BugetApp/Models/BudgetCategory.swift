//
//  BudgetCategory.swift
//  BugetApp
//
//  Created by AppleD0g on 3/14/25.
//

import Foundation
import CoreData


@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
}
