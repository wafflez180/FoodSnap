//
//  BusinessTaskView.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/20/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit

class BusinessTaskView: UIView {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var taskDescLabel: UILabel!
    @IBOutlet var exclusiveLabel: UILabel!
    var parentVC:HomeViewController!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "BusinessTaskView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    override func awakeFromNib() {
        setupUI()
    }
    
    func setupUI(){
        setupImageView()
    }
    
    func setupImageView(){
        imageView.layer.borderColor = UIColor.init(colorLiteralRed: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 1.0
    }
    
    @IBAction func pressedTaskView(_ sender: Any) {
        //REQUEST FOR ALL THE TASK'S PROPERTIES
        let taskExpandedViewController = BusinessTaskExpandedViewController(nibName: "BusinessTaskExpandedViewController", bundle: nil)
        parentVC.present(taskExpandedViewController, animated:true, completion:nil)
    }
}
