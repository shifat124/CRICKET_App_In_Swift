//
//  CustomTableViewCell.swift
//  CRIC_App
//
//  Created by BJIT on 21/11/1401 AP.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var localImgView: UIImageView!
    @IBOutlet weak var visitorImgView: UIImageView!
    @IBOutlet weak var localNickName: UILabel!
    @IBOutlet weak var visitorNickName: UILabel!
    @IBOutlet weak var localScore: UILabel!
    @IBOutlet weak var localWicket: UILabel!
    @IBOutlet weak var localOver: UILabel!
    @IBOutlet weak var visitorScore: UILabel!
    @IBOutlet weak var visitorWicket: UILabel!
    @IBOutlet weak var visitorOver: UILabel!
    @IBOutlet weak var matchComment: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        views()
        // Initialization code
        backView.layer.cornerRadius = 20
        
    }
    func views(){
        localImgView.round(10)
        visitorImgView.round(10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
