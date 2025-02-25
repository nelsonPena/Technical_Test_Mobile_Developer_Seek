//
//  ScannedEntity.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Geovanny Pena Agudelo on 15/10/23.
//

import Foundation
import CoreData

extension ScannedEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScannedEntity> {
        return NSFetchRequest<ScannedEntity>(entityName: "ScannedEntity")
    }
    @NSManaged public var id: UUID
    @NSManaged public var scan: String
    @NSManaged public var timestamp: Date
}
