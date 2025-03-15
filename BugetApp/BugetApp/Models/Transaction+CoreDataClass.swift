//
//  Transaction+CoreDataClass.swift
//  BugetApp
//
//  Created by AppleD0g on 3/15/25.
//


import Foundation
import CoreData

@objc(Transaction)
public class Transaction : NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
