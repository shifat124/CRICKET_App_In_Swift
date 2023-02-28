//
//  RecentMatchViewController.swift
//  CRIC_App
//
//  Created by BJIT on 28/11/1401 AP.
//

import UIKit

class RecentMatchViewController: UIViewController {
    var viewModel = ViewModel()
    var selectedCategory = 0
    var selectedTeam = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recIdLocImgView: UIImageView!
    @IBOutlet weak var recIdVisImgView: UIImageView!
    @IBOutlet weak var consfirstSeg: NSLayoutConstraint!
    @IBOutlet weak var firstViewBg: UIView!
    @IBOutlet weak var recIdLocNick: UILabel!
    @IBOutlet weak var consFirstView: NSLayoutConstraint!
    @IBOutlet weak var recIdVisNick: UILabel!
    @IBOutlet weak var maxCons: NSLayoutConstraint!
    @IBOutlet weak var firstCons: NSLayoutConstraint!
    @IBOutlet weak var recIdMatch: UILabel!
    @IBOutlet weak var recIdSeries: UILabel!
    @IBOutlet weak var recIdNote: UILabel!
    @IBOutlet weak var recIdVenueName: UILabel!
    @IBOutlet weak var recIdVenueImgView: UIImageView!
    @IBOutlet weak var consTableView: NSLayoutConstraint!
    var battingPlayersDataTeam1: [Batting] = []
    var battingPlayersDataTeam2: [Batting] = []
    var bowlingPlayersDataTeam1: [Bowling] = []
    var bowlingPlayersDataTeam2: [Bowling] = []
    var squadOfTeam1: [LineupInfo] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var squadOfTeam2: [LineupInfo] = []{
        
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "BattingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BattingTableViewCell")
        let nib1 = UINib(nibName: "SquadTableViewCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: "SquadTableViewCell")
        let nib2 = UINib(nibName: "InfoTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "InfoTableViewCell")
        let nibHeader = UINib(nibName: "scoreCardHeaderView", bundle: nil)
        tableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: "scoreCardHeaderView")
        setupBinder()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func categortySegmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            selectedCategory = 0
            break
        case 1:
            selectedCategory = 1
            break
            
        default:
            selectedCategory = 0
            break
        }
        self.tableView.reloadData()
        
    }
    @IBAction func teamSegmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            selectedTeam = 0
            break
        case 1:
            selectedTeam = 1
            
            break
        default:
            selectedTeam = 0
            
            break
        }
        
        self.tableView.reloadData()
    }
    func setupBinder(){
        viewModel.recentMatchDataById.bind{ [weak self] data in
            guard let battingPlayers = data?.data.batting else {
                print("Unable to access battings data")
                return
            }
            for battingPlayer in battingPlayers  {
                if battingPlayer.team_id == data?.data.localteam_id {
                    self?.battingPlayersDataTeam1.append(battingPlayer)
                    
                } else {
                    self?.battingPlayersDataTeam2.append(battingPlayer)
                    
                }
                
            }
            guard let bowlingPlayers = data?.data.bowling else {
                print("Unable to access battings data")
                return
            }
            for bowlingPlayer in bowlingPlayers  {
                if bowlingPlayer.team_id == data?.data.localteam_id {
                    self?.bowlingPlayersDataTeam1.append(
                        bowlingPlayer)
                    
                } else {
                    self?.bowlingPlayersDataTeam2.append(bowlingPlayer)
                }
                
            }
            
            guard let squadPlayers = data?.data.lineup else {
                print("Unable to access battings data")
                return
            }
            for squadPlayer in squadPlayers  {
                
                if squadPlayer.lineup?.team_id == data?.data.localteam_id {
                    self?.squadOfTeam1.append(
                        squadPlayer)
                    
                } else {
                    self?.squadOfTeam2.append(squadPlayer)
                }
                
            }
            
            DispatchQueue.main.async {
                self?.recIdLocNick.text = self?.viewModel.recentMatchDataById.value?.data.localteam?.code
                self?.recIdVisNick.text = self?.viewModel.recentMatchDataById.value?.data.visitorteam?.code
                if let localImage: String = self?.viewModel.recentMatchDataById.value?.data.localteam?.image_path {
                    self?.recIdLocImgView.sd_setImage(with: URL(string: localImage))
                }
                if let visitorImage: String = self?.viewModel.recentMatchDataById.value?.data.visitorteam?.image_path {
                    self?.recIdVisImgView.sd_setImage(with: URL(string: visitorImage))
                }
                let match: String = self?.viewModel.recentMatchDataById.value?.data.round ?? "No Value Found"
                self?.recIdMatch.text = "Match : " + match
                let locMatchType: String = (self?.viewModel.recentMatchDataById.value?.data.localteam?.name ?? "No Value")
                let visMatchType: String = (self?.viewModel.recentMatchDataById.value?.data.visitorteam?.name ?? "No Value")
                self?.recIdSeries.text = "Series : " + locMatchType + " VS " + visMatchType
                
                let note: String = self?.viewModel.recentMatchDataById.value?.data.note ?? "No Value Found"
                self?.recIdNote.text = "Note : " + note
                
                let venueName: String = self?.viewModel.recentMatchDataById.value?.data.venue?.name ?? "No Value Found"
                self?.recIdVenueName.text = "Venue : " + venueName
                
                if let upLocalImage: String = self?.viewModel.recentMatchDataById.value?.data.venue?.image_path {
                    self?.recIdVenueImgView.sd_setImage(with: URL(string: upLocalImage))
                }
                
                self?.tableView.reloadData()
            }
        }
    }
}
extension RecentMatchViewController: UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.firstViewBg.isHidden = true
                self?.consFirstView.constant = -200
                //                self?.consTableView.constant = 1000
                self?.maxCons.constant = 100
                self?.view.layoutIfNeeded()
            }
        }
        else {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.firstViewBg.isHidden = false
                self?.consFirstView.constant = 200
                //                self?.consTableView.constant = 200
                self?.maxCons.constant = 380
                
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectedCategory == 0{
            
            return 2
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCategory == 0 {
            if selectedTeam == 0 {
                switch section {
                case 0:
                    return self.battingPlayersDataTeam1.count
                case 1:
                    return self.bowlingPlayersDataTeam1.count
                default:
                    return 0
                    
                }
                
            } else {
                switch section {
                case 0:
                    return self.battingPlayersDataTeam2.count
                    
                case 1:
                    return self.bowlingPlayersDataTeam2.count
                default:
                    return 0
                    
                }
                
            }
        } else {
            if selectedTeam == 0 {
                switch section {
                    
                case 0:
                    return self.squadOfTeam1.count
                    
                default:
                    return 0
                    
                }
                
                
            } else {
                switch section {
                    
                case 0:
                    return self.squadOfTeam2.count
                    
                default:
                    return 0
                    
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedTeam == 0{
            switch selectedCategory {
            case 0:
                switch indexPath.section {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BattingTableViewCell", for: indexPath) as! BattingTableViewCell
                    cell.batsmanName.text = battingPlayersDataTeam1[indexPath.row].batsman?.fullname
                    cell.batRuns.text = String(battingPlayersDataTeam1[indexPath.row].score ?? 0)
                    cell.bowlFaced.text = String(battingPlayersDataTeam1[indexPath.row].ball ?? 0)
                    cell.batsFour.text = String(battingPlayersDataTeam1[indexPath.row].four_x ?? 0)
                    cell.batsSix.text = String(battingPlayersDataTeam1[indexPath.row].six_x ?? 0)
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BattingTableViewCell", for: indexPath) as! BattingTableViewCell
                    cell.batsmanName.text = bowlingPlayersDataTeam1[indexPath.row].bowler?.fullname
                    cell.batRuns.text = String(bowlingPlayersDataTeam1[indexPath.row].runs ?? 0)
                    cell.bowlFaced.text = String(bowlingPlayersDataTeam1[indexPath.row].overs ?? 0)
                    cell.batsFour.text = String(bowlingPlayersDataTeam1[indexPath.row].medians ?? 0)
                    cell.batsSix.text = String(bowlingPlayersDataTeam1[indexPath.row].rate ?? 0)
                    return cell
                default:
                    return UITableViewCell()
                }
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SquadTableViewCell", for: indexPath) as! SquadTableViewCell
                cell.playerName.text = squadOfTeam1[indexPath.row].fullname
                cell.playerImgView.sd_setImage(with: URL(string: squadOfTeam1[indexPath.row].image_path ?? ""), placeholderImage: UIImage(named: "person"))
                return cell
            default:
                break
            }
            
        } else {
            switch selectedCategory{
            case 0:
                switch indexPath.section {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BattingTableViewCell", for: indexPath) as! BattingTableViewCell
                    cell.batsmanName.text = battingPlayersDataTeam2[indexPath.row].batsman?.fullname
                    cell.batRuns.text = String(battingPlayersDataTeam2[indexPath.row].score ?? 0)
                    cell.bowlFaced.text = String(battingPlayersDataTeam2[indexPath.row].ball ?? 0)
                    cell.batsFour.text = String(battingPlayersDataTeam2[indexPath.row].four_x ?? 0)
                    cell.batsSix.text = String(battingPlayersDataTeam2[indexPath.row].six_x ?? 0)
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BattingTableViewCell", for: indexPath) as! BattingTableViewCell
                    cell.batsmanName.text = bowlingPlayersDataTeam2[indexPath.row].bowler?.fullname
                    cell.batRuns.text = String(bowlingPlayersDataTeam2[indexPath.row].runs ?? 0)
                    cell.bowlFaced.text = String(bowlingPlayersDataTeam2[indexPath.row].overs ?? 0)
                    cell.batsFour.text = String(bowlingPlayersDataTeam2[indexPath.row].medians ?? 0)
                    cell.batsSix.text = String(bowlingPlayersDataTeam2[indexPath.row].rate ?? 0)
                    
                    return cell
                default:
                    return UITableViewCell()
                }
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SquadTableViewCell", for: indexPath) as! SquadTableViewCell
                cell.playerName.text = squadOfTeam2[indexPath.row].fullname
                cell.playerImgView.sd_setImage(with: URL(string: squadOfTeam2[indexPath.row].image_path ?? ""), placeholderImage: UIImage(named: "person"))
                return cell
            default:
                break
            }
            
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "scoreCardHeaderView") as! scoreCardHeaderView
        if selectedCategory == 0 {
            if section == 0 {
                header.hedName.text = "Batsman Name"
                header.hedRuns.text = "Runs"
                header.hedBowl.text = "Bowl"
                header.hedFour.text = "Four"
                header.hedSix.text = "Six"
            } else {
                
                header.hedName.text = "Bowler Name"
                header.hedRuns.text = "Runs"
                header.hedBowl.text = "Overs"
                header.hedFour.text = "Meden"
                header.hedSix.text = "Rate"
            }
            return header
            
        } else {
            
            return UIView()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(selectedCategory == 0) {
            return 40
        }
        else {
            return 80
        }
    }
}

extension RecentMatchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
    
}




