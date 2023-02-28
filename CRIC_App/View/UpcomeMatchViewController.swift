//
//  UpcomeMatchViewController.swift
//  CRIC_App
//
//  Created by BJIT on 27/11/1401 AP.
//

import UIKit

class UpcomeMatchViewController: UIViewController {
    @IBOutlet weak var locImgWithId: UIImageView!
    @IBOutlet weak var visImgWithId: UIImageView!
    @IBOutlet weak var locTitleWithId: UILabel!
    @IBOutlet weak var visTitleWithId: UILabel!
    @IBOutlet weak var upMatchComment: UILabel!
    @IBOutlet weak var upMatchType: UILabel!
    @IBOutlet weak var upMatchDate: UILabel!
    @IBOutlet weak var upMatchVenueName: UILabel!
    @IBOutlet weak var venueImgTitle: UILabel!
    @IBOutlet weak var upMatchVenueImage: UIImageView!
    var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        views()
        setupBinder()
    }
    func views(){
        locImgWithId.round(20)
        visImgWithId.round(20)
    }
    
    func setupBinder(){
        viewModel.upcomingMatchDataById.bind{ [weak self] data in
            DispatchQueue.main.async {
                self?.locTitleWithId.text = self?.viewModel.upcomingMatchDataById.value?.data?.localteam?.name
                self?.visTitleWithId.text = self?.viewModel.upcomingMatchDataById.value?.data?.visitorteam?.name
                
                let localImage = self?.viewModel.upcomingMatchDataById.value?.data?.localteam?.imagePath
                
                if let image = localImage {
                    self?.locImgWithId.sd_setImage(with: URL(string: image))
                }
                
                let visitorImage = self?.viewModel.upcomingMatchDataById.value?.data?.visitorteam?.imagePath
                
                if let image = visitorImage {
                    self?.visImgWithId.sd_setImage(with: URL(string: image))
                }
                
                let match = self?.viewModel.upcomingMatchDataById.value?.data?.round ?? "No Value Found"
                
                self?.upMatchComment.text = "Match : " + match
                let locMatchType = (self?.viewModel.upcomingMatchDataById.value?.data?.localteam?.code ?? "No Value")
                let visMatchType = (self?.viewModel.upcomingMatchDataById.value?.data?.visitorteam?.code ?? "No Value")
                self?.upMatchType.text = "Series : " + locMatchType + " VS " + visMatchType
                
                let dateString = self?.viewModel.upcomingMatchDataById.value?.data?.startingAt
                let inputFormatter = ISO8601DateFormatter()
                inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                
                if let date = inputFormatter.date(from: dateString ?? "No Date") {
                    let outputFormatter = DateFormatter()
                    outputFormatter.dateFormat = "MMMM dd, yyyy"
                    let outputString = outputFormatter.string(from: date)
                    self?.upMatchDate.text = "Date : " + outputString
                    
                    
                } else {
                    print("Invalid date string")
                }
                
                self?.upMatchVenueName.text = "Venue Name : " +  (self?.viewModel.upcomingMatchDataById.value?.data?.venue?.name ?? "No value") + " , " + (self?.viewModel.upcomingMatchDataById.value?.data?.venue?.city ?? "No Value")
                
                
                let upLocalImage = self?.viewModel.upcomingMatchDataById.value?.data?.venue?.imagePath
                
                if let image = upLocalImage {
                    self?.upMatchVenueImage.sd_setImage(with: URL(string: image))
                }
                else {
                    self?.venueImgTitle.text = "No Image"
                }
                
            }
        }
    }
}
