//
//  RankingTableViewCell.swift
//  CRIC_App
//
//  Created by BJIT on 01/12/1401 AP.
//

import UIKit

class RankingTableViewCell: UITableViewCell {
    @IBOutlet weak var rankingPosition: UILabel!
    @IBOutlet weak var rankingName: UILabel!
    @IBOutlet weak var rankingCountryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
