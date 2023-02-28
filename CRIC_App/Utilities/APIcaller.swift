//
//  APIcaller.swift
//  CRIC_App
//
//  Created by BJIT on 24/11/1401 AP.
//

import Foundation
import UIKit

class APIcaller{
    
    static let shared = APIcaller()
    private init(){}
    
    func getRecentMatches(completion: @escaping (RecentMatch?) -> ()) {
        
        // Fire the request to API
        
        // Create a string URL
        let stringURL = "https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=lSCiYynw4Q4kdiPGZzWQt5VEPYSkGWN3lUXTdOATLwIog64ffRYsPFgZkerD&filter%5Bstatus%5D=Finished&include=runs,localteam,visitorteam,venue&sort=-starting_at&fields%5Bteams%5D=name,image_path,code"
            
        // Create URL object
        let url =  URL(string: stringURL)
            
        // Check that URL was created
        guard url != nil else {
            print("Could not create URL")
            return
        }
        
       
            
            
        // Get the URL session
        let session = URLSession.shared
            
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Parse the returned JSON into article instances
                
                let decoder = JSONDecoder()
                do {
                    let recentMatch = try decoder.decode(RecentMatch.self, from: data!)
                    //dump(articleService)
                    //dump(recentMatch.data?[0].localteam)
                    completion(recentMatch)
                    
                    


                } catch {
                    print("Could not decode the json data")
                }
            }
            else {
                print("Error creating dataTask")
            }
        }
            
        // Start the data task
        dataTask.resume()
    }
    
    func getRecentMatchesById(id: Int, completion: @escaping (RecentMatchScorecardAndSquad?) -> ()) {
        
        // Fire the request to API
        
        // Create a string URL
        let stringURL = "https://cricket.sportmonks.com/api/v2.0/fixtures/\(id)?include=runs,localteam,visitorteam,league,stage,venue,batting.batsman,bowling.bowler,tosswon,winnerteam,manofmatch,tosswon,localteam.results,visitorteam.results,batting.result,lineup&api_token=lSCiYynw4Q4kdiPGZzWQt5VEPYSkGWN3lUXTdOATLwIog64ffRYsPFgZkerD"
        
        
        
        
   
   
        // Create URL object
        let url =  URL(string: stringURL)
            
        // Check that URL was created
        guard url != nil else {
            print("Could not create URL")
            return
        }
        
       
            
            
        // Get the URL session
        let session = URLSession.shared
            
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Parse the returned JSON into article instances
                
                let decoder = JSONDecoder()
                do {
                    
                    let recentMatch = try decoder.decode(RecentMatchScorecardAndSquad.self, from: data!)
                    //dump(articleService)
                    //dump(recentMatch.data?[0].localteam)
                    completion(recentMatch)
                    
                    


                } catch {
                    print("Could not decode the json data")
                }
            }
            else {
                print("Error creating dataTask")
            }
        }
            
        // Start the data task
        dataTask.resume()
    }
    
    
    func getUpcomingMatchById(id: Int, completion: @escaping (UpcomingModelByID?) -> ()){
        
        // Fire the request to API
        
        // Create a string URL
        let stringURL = "https://cricket.sportmonks.com/api/v2.0/fixtures/\(id)?api_token=lSCiYynw4Q4kdiPGZzWQt5VEPYSkGWN3lUXTdOATLwIog64ffRYsPFgZkerD&filter%5Bstatus%5D=NS&include=runs,localteam,visitorteam,venue&sort=starting_at&fields%5Bteams%5D=name,image_path,code"
        
        


            
        // Create URL object
        let url =  URL(string: stringURL)
            
      
        // Check that URL was created
        guard url != nil else {
            print("Could not create URL")
            return
        }
        
       
            
            
        // Get the URL session
        let session = URLSession.shared
            
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Parse the returned JSON into article instances
                
                let decoder = JSONDecoder()
                do {
                    
                    print("data:",data!)
                    let upcomingMatch = try decoder.decode(UpcomingModelByID.self, from: data!)
//                    print("dump upcoming data from API response")
//                    dump(upcomingMatch)
                    completion(upcomingMatch)
                    
                    


                } catch {
                    print("Could not decode the json data upcoming")
                }
            }
            else {
                print("Error creating dataTask")
            }
        }
            
        // Start the data task
        dataTask.resume()
        
    }
    
    func getUpcomingMatches(completion: @escaping (UpcomingMatch?) -> ()) {
        
        // Fire the request to API
        
        // Create a string URL
        let stringURL = "https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=lSCiYynw4Q4kdiPGZzWQt5VEPYSkGWN3lUXTdOATLwIog64ffRYsPFgZkerD&filter%5Bstatus%5D=NS&include=runs,localteam,visitorteam,venue&sort=starting_at&fields%5Bteams%5D=name,image_path,code"

            
        // Create URL object
        let url =  URL(string: stringURL)
            
        // Check that URL was created
        guard url != nil else {
            print("Could not create URL")
            return
        }
        
       
            
            
        // Get the URL session
        let session = URLSession.shared
            
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Parse the returned JSON into article instances
                
                let decoder = JSONDecoder()
                do {
                    
                    print("data:",data!)
                    let upcomingMatch = try decoder.decode(UpcomingMatch.self, from: data!)
                    
                    //dump(upcomingMatch)
                    completion(upcomingMatch)
                    
                    


                } catch {
                    print("Could not decode the json data upcoming")
                }
            }
            else {
                print("Error creating dataTask")
            }
        }
            
        // Start the data task
        dataTask.resume()
    }
    
    func getRanking(completion: @escaping (RankingModel?) -> ()) {
        
        // Fire the request to API
        
        // Create a string URL
        let stringURL = "https://cricket.sportmonks.com/api/v2.0/team-rankings?api_token=lSCiYynw4Q4kdiPGZzWQt5VEPYSkGWN3lUXTdOATLwIog64ffRYsPFgZkerD"
            
        // Create URL object
        let url =  URL(string: stringURL)
            
        // Check that URL was created
        guard url != nil else {
            print("Could not create URL")
            return
        }
        
       
            
            
        // Get the URL session
        let session = URLSession.shared
            
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Parse the returned JSON into article instances
                
                let decoder = JSONDecoder()
                do {
                    let recentMatch = try decoder.decode(RankingModel.self, from: data!)
                    //dump(articleService)
                    //dump(recentMatch.data?[0].localteam)
                    completion(recentMatch)
                    
                    


                } catch {
                    print("Could not decode the json data")
                }
            }
            else {
                print("Error creating dataTask")
            }
        }
            
        // Start the data task
        dataTask.resume()
    }
    
    
    func getSearchPlayer(completion: @escaping (SearchPlayer?) -> ()) {
        
        // Fire the request to API
        
        // Create a string URL
        let stringURL = "https://cricket.sportmonks.com/api/v2.0/players?fields[players]=id,fullname,image_path&api_token=lSCiYynw4Q4kdiPGZzWQt5VEPYSkGWN3lUXTdOATLwIog64ffRYsPFgZkerD"
            
        // Create URL object
        let url =  URL(string: stringURL)
            
        // Check that URL was created
        guard url != nil else {
            print("Could not create URL")
            return
        }
        
       
            
            
        // Get the URL session
        let session = URLSession.shared
            
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Parse the returned JSON into article instances
                
                let decoder = JSONDecoder()
                do {
                    let recentMatch = try decoder.decode(SearchPlayer.self, from: data!)
                    //dump(articleService)
                    //dump(recentMatch.data?[0].localteam)
                    completion(recentMatch)
                    
                    


                } catch {
                    print("Could not decode the json data")
                }
            }
            else {
                print("Error creating dataTask")
            }
        }
            
        // Start the data task
        dataTask.resume()
    }
    
    func getCareerById(id: Int, completion: @escaping (CareerDataModel?) -> ()){
        
        // Fire the request to API
        
        print("Player id form getCareerById:", id)
        
        // Create a string URL
        let stringURL = "https://cricket.sportmonks.com/api/v2.0/players/\(id)?include=career.season,country&api_token=lSCiYynw4Q4kdiPGZzWQt5VEPYSkGWN3lUXTdOATLwIog64ffRYsPFgZkerD"
        
        
   
        


            
        // Create URL object
        let url =  URL(string: stringURL)
            
      
        // Check that URL was created
        guard url != nil else {
            print("Could not create URL")
            return
        }
        
       
            
            
        // Get the URL session
        let session = URLSession.shared
            
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Parse the returned JSON into article instances
                
                let decoder = JSONDecoder()
                do {
                    
                    print("data:",data!)
                    let upcomingMatch = try decoder.decode(CareerDataModel.self, from: data!)
//                    print("dump upcoming data from API response")
//                    dump(upcomingMatch)
                    completion(upcomingMatch)
                    
                    


                } catch {
                    print("Could not decode the json data upcoming")
                }
            }
            else {
                print("Error creating dataTask")
            }
        }
            
        // Start the data task
        dataTask.resume()
        
    }
    
    
    
    
}


