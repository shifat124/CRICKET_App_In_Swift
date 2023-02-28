//
//  SquadTableViewCell.swift
//  CRIC_App
//
//  Created by BJIT on 04/12/1401 AP.
//

import UIKit

class SquadTableViewCell: UITableViewCell {
    @IBOutlet weak var playerImgView: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
