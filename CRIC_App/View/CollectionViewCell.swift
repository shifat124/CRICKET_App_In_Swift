//
//  CollectionViewCell.swift
//  CRIC_App
//
//  Created by BJIT on 14/2/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var constCollectionview: NSLayoutConstraint!
    @IBOutlet weak var backViewC: UIView!
    @IBOutlet weak var cell1: UICollectionViewCell!
    @IBOutlet weak var locImgView: UIImageView!
    @IBOutlet weak var locTitle: UILabel!
    @IBOutlet weak var visImgView: UIImageView!
    @IBOutlet weak var venueTitle: UILabel!
    @IBOutlet weak var visTitle: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        views()
        
    }
    func views(){
        locImgView.round(10)
        visImgView.round(10)
    }
}
