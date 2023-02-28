//
//  CareerPlayerViewController.swift
//  CRIC_App
//
//  Created by BJIT on 05/12/1401 AP.
//

import UIKit

class CareerPlayerViewController: UIViewController {
    var viewModel = ViewModel()
    @IBOutlet weak var careerPlayerName: UILabel!
    @IBOutlet weak var careerPlayerBirthDate: UILabel!
    @IBOutlet weak var careerPlayerBatStyle: UILabel!
    @IBOutlet weak var careerPlayerBowlStyle: UILabel!
    @IBOutlet weak var careerPlayerCountry: UILabel!
    @IBOutlet weak var careerPlayerImage: UIImageView!
    @IBOutlet weak var careerPlayerCountryImage: UIImageView!
    @IBOutlet weak var t20Matches: UILabel!
    @IBOutlet weak var t20Runs: UILabel!
    @IBOutlet weak var t20Avg: UILabel!
    @IBOutlet weak var t20Str: UILabel!
    @IBOutlet weak var t20Hund: UILabel!
    @IBOutlet weak var t20Fif: UILabel!
    @IBOutlet weak var odiMatch: UILabel!
    @IBOutlet weak var odiRuns: UILabel!
    @IBOutlet weak var odiAvg: UILabel!
    @IBOutlet weak var odiStr: UILabel!
    @IBOutlet weak var odiHund: UILabel!
    @IBOutlet weak var odiFifty: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinder()
        // Do any additional setup after loading the view.
    }
    
    
    func setUpBinder() {
        viewModel.careerPlayers.bind{ [weak self] data in
            DispatchQueue.main.async {
                self?.careerPlayerName.text = "Name : " + (self?.viewModel.careerPlayers.value?.data?.fullname ?? "nil")
                self?.careerPlayerBirthDate.text = "Date Of Birth : " + (self?.viewModel.careerPlayers.value?.data?.dateofbirth ?? "nil")
                self?.careerPlayerCountry.text = "Country : " + (self?.viewModel.careerPlayers.value?.data?.country?.name ?? "nil")
                self?.careerPlayerBatStyle.text = "Batting Style : " + (self?.viewModel.careerPlayers.value?.data?.battingstyle ?? "nil")
                self?.careerPlayerBowlStyle.text = "Country : " + (self?.viewModel.careerPlayers.value?.data?.bowlingstyle ?? "nil")
                let localImage = self?.viewModel.careerPlayers.value?.data?.image_path
                if let image = localImage {
                    self?.careerPlayerImage.sd_setImage(with: URL(string: image))
                }
                let countrylocalImage = self?.viewModel.careerPlayers.value?.data?.country?.image_path
                
                if let image = countrylocalImage {
                    self?.careerPlayerCountryImage.sd_setImage(with: URL(string: image))
                }
                self?.t20Matches.text = String(self?.viewModel.careerPlayers.value?.data?.career?[1].batting?["matches"] ?? 0.0)
                self?.t20Runs.text = String(self?.viewModel.careerPlayers.value?.data?.career?[1].batting?["runs_scored"] ?? 0.0)
                self?.t20Avg.text = String(self?.viewModel.careerPlayers.value?.data?.career?[1].batting?["average"] ?? 0.0)
                self?.t20Str.text = String(self?.viewModel.careerPlayers.value?.data?.career?[1].batting?["strike_rate"] ?? 0.0)
                self?.t20Hund.text = String(self?.viewModel.careerPlayers.value?.data?.career?[1].batting?["hundreds"] ?? 0)
                self?.t20Fif.text = String(self?.viewModel.careerPlayers.value?.data?.career?[1].batting?["fifties"] ?? 0)
                self?.odiMatch.text = String(self?.viewModel.careerPlayers.value?.data?.career?[2].batting?["matches"] ?? 0.0)
                self?.odiRuns.text = String(self?.viewModel.careerPlayers.value?.data?.career?[2].batting?["runs_scored"] ?? 0.0)
                self?.odiAvg.text = String(self?.viewModel.careerPlayers.value?.data?.career?[2].batting?["average"] ?? 0.0)
                self?.odiStr.text = String(self?.viewModel.careerPlayers.value?.data?.career?[2].batting?["strike_rate"] ?? 0.0)
                self?.odiHund.text = String(self?.viewModel.careerPlayers.value?.data?.career?[2].batting?["hundreds"] ?? 0.0)
                self?.odiFifty.text = String(self?.viewModel.careerPlayers.value?.data?.career?[2].batting?["fifties"] ?? 0.0)
            }
        }
    }
}
