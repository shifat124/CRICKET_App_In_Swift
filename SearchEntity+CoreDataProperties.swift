//
//  SearchEntity+CoreDataProperties.swift
//  CRIC_App
//
//  Created by BJIT on 05/12/1401 AP.
//
//

import Foundation
import CoreData
extension SearchEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchEntity> {
        return NSFetchRequest<SearchEntity>(entityName: "SearchEntity")
    }
    @NSManaged public var id: Int64
    @NSManaged public var fullName: String?
    @NSManaged public var imagePath: String?
    
}
extension SearchEntity : Identifiable {
    
}
