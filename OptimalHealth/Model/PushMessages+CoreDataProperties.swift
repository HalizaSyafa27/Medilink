//
//  PushMessages+CoreDataProperties.swift
//  
//
//  Created by OdiTek Solutions on 02/07/19.
//
//

import Foundation
import CoreData


extension PushMessages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PushMessages> {
        return NSFetchRequest<PushMessages>(entityName: "PushMessages")
    }

    @NSManaged public var msg: String?
    @NSManaged public var id: String?
    @NSManaged public var userId: String?
    @NSManaged public var date: String?
    @NSManaged public var readStatus: Bool
    @NSManaged public var insertedDate: Date?
    @NSManaged public var type: String?

}
