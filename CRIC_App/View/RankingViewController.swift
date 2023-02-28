//
//  RankingViewController.swift
//  CRIC_App
//
//  Created by BJIT on 01/12/1401 AP.
//

import UIKit

class RankingViewController: UIViewController {
    var viewModel = ViewModel()
    @IBOutlet weak var rankingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRankingFromApi()
        viewModel.rankingData.bind{
            data in
            //print("ranking data:",data)
            DispatchQueue.main.async {
                self.rankingTableView.reloadData()
            }
        }
        if !NetworkFunc.shared.isInternetAvailable() {
            let alert = UIAlertController(title: "No Internet Connection",
                                          message: "Please check your internet connection and try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        let nib = UINib(nibName: "RankingTableViewCell", bundle: nil)
        rankingTableView.register(nib, forCellReuseIdentifier: "rankingnib")
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
}


extension RankingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ICC Men Test Ranking"
        }
        else if section == 1 {
            return "ICC Men ODI Ranking"
        }
        else {
            return "ICC Men T20I Ranking"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rankingData.value?.data?[0].team?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rankingTableView.dequeueReusableCell(withIdentifier: "rankingnib", for: indexPath) as! RankingTableViewCell
        if indexPath.section == 0 {
            cell.rankingPosition.text = String(viewModel.rankingData.value?.data?[0].team?[indexPath.row].ranking?.position ?? 0)
            cell.rankingName.text = viewModel.rankingData.value?.data?[0].team?[indexPath.row].name
            let localImage = viewModel.rankingData.value?.data?[0].team?[indexPath.row].imagePath
            
            if let image = localImage {
                cell.rankingCountryImage.sd_setImage(with: URL(string: image))
            }
        }
        else if indexPath.section == 1 {
            cell.rankingName.text = viewModel.rankingData.value?.data?[1].team?[indexPath.row].name
            cell.rankingPosition.text = String(viewModel.rankingData.value?.data?[1].team?[indexPath.row].ranking?.position ?? 0)
            let localImage = viewModel.rankingData.value?.data?[1].team?[indexPath.row].imagePath
            if let image = localImage {
                cell.rankingCountryImage.sd_setImage(with: URL(string: image))
            }
        }
        else {
            cell.rankingName.text = viewModel.rankingData.value?.data?[2].team?[indexPath.row].name
            cell.rankingPosition.text = String(viewModel.rankingData.value?.data?[2].team?[indexPath.row].ranking?.position ?? 0)
            let localImage = viewModel.rankingData.value?.data?[2].team?[indexPath.row].imagePath
            if let image = localImage {
                cell.rankingCountryImage.sd_setImage(with: URL(string: image))
            }
        }
        return cell
    }
}
extension RankingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
    
    
}
