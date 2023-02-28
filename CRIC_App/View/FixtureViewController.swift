//
//  FixtureViewController.swift
//  CRIC_App
//
//  Created by BJIT on 03/12/1401 AP.
//

import UIKit

class FixtureViewController: UIViewController {
    var viewModel = ViewModel()
    @IBOutlet weak var fixtureTableView: UITableView!
    @IBOutlet weak var datePickerFixture: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureTableView.dataSource = self
        fixtureTableView.delegate = self
        let nib = UINib(nibName: "FixtureTableViewCell", bundle: nil)
        fixtureTableView.register(nib, forCellReuseIdentifier: "fixturecell")
        viewModel.getDataFromApi()
        if !NetworkFunc.shared.isInternetAvailable() {
            let alert = UIAlertController(title: "No Internet Connection",
                                          message: "Please check your internet connection and try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        viewModel.upcomingMatchData.bind { [weak self] data in
            DispatchQueue.main.async {
                self?.fixtureTableView.reloadData()
            }
        }
        
    }
    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: sender.date)
        print("Selected date: \(selectedDate)")
    }
}
extension FixtureViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingMatchData.value?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fixturecell", for: indexPath) as! FixtureTableViewCell
        let localImage = viewModel.upcomingMatchData.value?.data?[indexPath.row].localteam?.imagePath
        if let image = localImage {
            cell.fixLocalImg.sd_setImage(with: URL(string: image))
        }
        let visitorImage = viewModel.upcomingMatchData.value?.data?[indexPath.row].visitorteam?.imagePath
        if let image = visitorImage {
            cell.fixVisitImg.sd_setImage(with: URL(string: image))
        }
        cell.fixLocalName.text = viewModel.upcomingMatchData.value?.data?[indexPath.row].localteam?.name
        cell.fixVisitName.text = viewModel.upcomingMatchData.value?.data?[indexPath.row].visitorteam?.name
        let dateString = viewModel.upcomingMatchData.value?.data?[indexPath.row].starting_at
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = inputFormatter.date(from: dateString ?? "No Date") {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM dd, yyyy"
            let outputString = outputFormatter.string(from: date)
            cell.fixMatchDate.text = outputString
        } else {
            print("Invalid date string")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension FixtureViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
}





