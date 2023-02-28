//
//  FixtureTableViewCell.swift
//  CRIC_App
//
//  Created by BJIT on 03/12/1401 AP.
//

import UIKit

class FixtureTableViewCell: UITableViewCell {
    @IBOutlet weak var fixLocalImg: UIImageView!
    @IBOutlet weak var fixVisitImg: UIImageView!
    @IBOutlet weak var fixLocalName: UILabel!
    @IBOutlet weak var fixVisitName: UILabel!
    @IBOutlet weak var fixMatchDate: UILabel!
    @IBOutlet weak var fixBackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fixBackView.layer.cornerRadius = 20
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
