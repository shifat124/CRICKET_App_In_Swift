//
//  ViewModel.swift
//  CRIC_App
//
//  Created by BJIT on 24/11/1401 AP.
//

import Foundation

class ViewModel {
    var recentMatchData: ObservableObject<RecentMatch?> = ObservableObject(nil)
    var upcomingMatchData: ObservableObject<UpcomingMatch?> = ObservableObject(nil)
    var upcomingMatchDataById: ObservableObject<UpcomingModelByID?> = ObservableObject(nil)
    var recentMatchDataById: ObservableObject<RecentMatchScorecardAndSquad?> = ObservableObject(nil)
    var rankingData: ObservableObject<RankingModel?> = ObservableObject(nil)
    var searchedPlayers: ObservableObject<SearchPlayer?> = ObservableObject(nil)
    var careerPlayers: ObservableObject<CareerDataModel?> = ObservableObject(nil)
    func getDataFromApi() {
        APIcaller.shared.getRecentMatches { [weak self] data in
            self?.recentMatchData.value = data
        }
        APIcaller.shared.getUpcomingMatches { [weak self] data in
            dump(data)
            self?.upcomingMatchData.value = data
        }
    }
    
    func getUpcomingDataFromApi(id: Int)
    {
        
        APIcaller.shared.getUpcomingMatchById(id: id){  [weak self] data in
            
            self?.upcomingMatchDataById.value = data
        }
        
    }
    
    func getRecentDataFromApi(id: Int)
    {
        APIcaller.shared.getRecentMatchesById(id: id){  [weak self] data in
            
            self?.recentMatchDataById.value = data
        }
        
    }
    
    func getRankingFromApi() {
        APIcaller.shared.getRanking { [weak self] data in
            
            self?.rankingData.value = data
        }
    }
    
    
    func getSearchPlayerFromAPI() {
        APIcaller.shared.getSearchPlayer { [weak self] data in
            self?.searchedPlayers.value = data
        }
    }
    
    
    func getPlayersCareerFromApi(id: Int)
    {
        print("player id:",id)
        APIcaller.shared.getCareerById(id: id){  [weak self] data in
            self?.careerPlayers.value = data
            print("Player data:", data?.data?.fullname)
        }
        
    }
}
