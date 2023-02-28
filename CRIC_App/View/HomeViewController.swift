//
//  ViewController.swift
//  CRIC_App
//
//  Created by BJIT on 20/11/1401 AP.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    var viewModel = ViewModel()
    @IBOutlet weak var consCollectionView: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleNotification(title: "Upcoming Match", body: "Starts in 15 minutes", timeInterval: 10)
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        if !NetworkFunc.shared.isInternetAvailable() {
            let alert = UIAlertController(title: "No Internet Connection",
                                          message: "Please check your internet connection and try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib1 = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib1, forCellWithReuseIdentifier:  "XIBCollectionView")
        viewModel.getDataFromApi()
        
        viewModel.recentMatchData.bind { [weak self] data in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
            }
            
        }
        viewModel.upcomingMatchData.bind { [weak self] data in
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }
    func scheduleNotification(title: String, body: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        if segue.identifier == "upcomematch" {
            if let dest = segue.destination as? UpcomeMatchViewController{
                dest.viewModel.getUpcomingDataFromApi(id: (viewModel.upcomingMatchData.value?.data?[indexPath.row].id)!)
            }
        }
        else if segue.identifier == "recentmatch" {
            if let dest = segue.destination as? RecentMatchViewController{
                dest.viewModel.getRecentDataFromApi(id: (viewModel.recentMatchData.value?.data?[indexPath.row].id)!)
            }
            
        }
    }
}
extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "upcomematch", sender: indexPath)
    }
    
}
extension ViewController: UICollectionViewDataSource{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.collectionView.isHidden = true
                self?.consCollectionView.constant = -200
                self?.view.layoutIfNeeded()
            }
        }
        else {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.collectionView.isHidden = false
                self?.consCollectionView.constant = 200
                self?.view.layoutIfNeeded()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.upcomingMatchData.value?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XIBCollectionView", for: indexPath) as! CollectionViewCell
        let localImage = viewModel.upcomingMatchData.value?.data?[indexPath.row].localteam?.imagePath
        if let image = localImage {
            cell.locImgView.sd_setImage(with: URL(string: image))
        }
        let visitorImage = viewModel.upcomingMatchData.value?.data?[indexPath.row].visitorteam?.imagePath
        if let image = visitorImage {
            cell.visImgView.sd_setImage(with: URL(string: image))
        }
        cell.locTitle.text = viewModel.upcomingMatchData.value?.data?[indexPath.row].localteam?.code
        cell.visTitle.text = viewModel.upcomingMatchData.value?.data?[indexPath.row].visitorteam?.code
        cell.venueTitle.text = viewModel.upcomingMatchData.value?.data?[indexPath.row].venue?.name ?? "Venue Has Not Decided"
        let dateString = viewModel.upcomingMatchData.value?.data?[indexPath.row].starting_at ?? "nil"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("Invalid date string")
        }
        let timeLeftLabel = UILabel()
        func updateTimeLeftLabel() {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day, .hour, .minute, .second]
            formatter.unitsStyle = .full
            formatter.zeroFormattingBehavior = .dropAll
            let timeLeftString = formatter.string(from: Date(), to: date)!
            cell.matchDate.text = "\(timeLeftString) Left"
        }
        updateTimeLeftLabel()
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            updateTimeLeftLabel()
        }
        cell.typeLabel.text = viewModel.upcomingMatchData.value?.data?[indexPath.row].round
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentMatchData.value?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let localImage = viewModel.recentMatchData.value?.data?[indexPath.row].localteam?.imagePath
        if let image = localImage {
            cell.localImgView.sd_setImage(with: URL(string: image))
        }
        let visitorImage = viewModel.recentMatchData.value?.data?[indexPath.row].visitorteam?.imagePath
        if let image = visitorImage {
            cell.visitorImgView.sd_setImage(with: URL(string: image))
        }
        cell.localNickName.text = viewModel.recentMatchData.value?.data?[indexPath.row].localteam?.name
        cell.visitorNickName.text = viewModel.recentMatchData.value?.data?[indexPath.row].visitorteam?.name
        cell.matchComment.text = viewModel.recentMatchData.value?.data?[indexPath.row].note
        if (viewModel.recentMatchData.value?.data?[indexPath.row].localteamID == viewModel.recentMatchData.value?.data?[indexPath.row].runs?[0].teamID) {
            cell.localScore.text = String(viewModel.recentMatchData.value?.data?[indexPath.row].runs?[0].score ?? 0)
            cell.localWicket.text = "/" + String(viewModel.recentMatchData.value?.data?[indexPath.row].runs![0].wickets ?? 0)
            cell.localOver.text = String(viewModel.recentMatchData.value?.data?[indexPath.row].runs?[0].overs ?? 0.0)
            cell.visitorScore.text = String(viewModel.recentMatchData.value?.data?[indexPath.row].runs?[1].score ?? 0)
            cell.visitorWicket.text = "/" + String(viewModel.recentMatchData.value?.data?[indexPath.row].runs![1].wickets ?? 0)
            cell.visitorOver.text = String(viewModel.recentMatchData.value?.data?[indexPath.row].runs?[1].overs ?? 0.0)
        }
        else {
            cell.localScore.text = String(viewModel.recentMatchData.value?.data?[indexPath.row].runs?[1].score ?? 0)
            cell.localWicket.text = "/" + String(viewModel.recentMatchData.value?.data?[indexPath.row].runs![1].wickets ?? 0)
            cell.localOver.text = String(viewModel.recentMatchData.value?.data?[indexPath.row].runs?[1].overs ?? 0.0)
            cell.visitorScore.text = String(viewModel.recentMatchData.value?.data?[indexPath.row].runs?[0].score ?? 0)
            cell.visitorWicket.text = "/" + String(viewModel.recentMatchData.value?.data?[indexPath.row].runs![0].wickets ?? 0)
            cell.visitorOver.text = String(viewModel.recentMatchData.value?.data?[indexPath.row].runs?[0].overs ?? 0.0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        performSegue(withIdentifier: "recentmatch", sender: indexPath)
        
    }
    
}







//api_token=lSCiYynw4Q4kdiPGZzWQt5VEPYSkGWN3lUXTdOATLwIog64ffRYsPFgZkerD
