//
//  ConfigCoreData.swift
//  CRIC_App
//
//  Created by BJIT on 05/12/1401 AP.
//

import Foundation
import CoreData
import UIKit

class configCoreData {
    
    static let shared = configCoreData()
    
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addItemsBatchInsert(data: SearchPlayer) {

            var playerDictionary = [String: Any]()
            var dataArray = [[String: Any]]()
            
            for item in (data.data ?? []) {
                playerDictionary = [
                    "id": item.id,
                    "fullName": item.fullname,
                    "imagePath": item.image_path
                ]
                dataArray.append(playerDictionary)
            }
            
            let request = NSBatchInsertRequest(entity: SearchEntity.entity(), objects: dataArray)

            do {
                let result = try context.execute(request) as? NSBatchInsertResult
                let success = result?.result as? Bool ?? false
                if success {
                    print("Data inserted successfully")
                }
            } catch {
                print("Error inserting data: \(error)")
            }
        }
    
    func getAllRecords(search: String) -> [SearchEntity] {
            var playerArray = [SearchEntity]()
            do {
                
                let fetchRequest = NSFetchRequest<SearchEntity>(entityName: "SearchEntity")
                
                let predicate = NSPredicate(format: "fullName CONTAINS [c] %@", search)
                fetchRequest.predicate = predicate

                playerArray = try context.fetch(fetchRequest)
            }
            catch {
                print(error.localizedDescription)
            }
            return playerArray
        }
}
