//
//  BattingTableViewCell.swift
//  CRIC_App
//
//  Created by BJIT on 04/12/1401 AP.
//

import UIKit

class BattingTableViewCell: UITableViewCell {
    @IBOutlet weak var batsmanName: UILabel!
    @IBOutlet weak var batRuns: UILabel!
    @IBOutlet weak var bowlFaced: UILabel!
    @IBOutlet weak var batsFour: UILabel!
    @IBOutlet weak var batsSix: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
