//
//  SharedPhotoCellTableViewCell.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/21/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit

class SharedPhotoTableViewCell: UITableViewCell {

    @IBOutlet var companyImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var taskDescLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var getCouponButton: UIButton!
    
    //MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - SharedPhotoTableViewCell
    
    func setupUI(){
        setupImageView()
    }
    
    func setupImageView(){
        companyImageView.layer.borderColor = UIColor.init(colorLiteralRed: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        companyImageView.layer.borderWidth = 1.0
    }

}
