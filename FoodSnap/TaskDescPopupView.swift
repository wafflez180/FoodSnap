//
//  TaskDescPopupView.swift
//  
//
//  Created by Arthur De Araujo on 6/20/17.
//
//

import UIKit

class TaskDescPopupView: UIView {

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tagsDescLabel: UILabel!
    var parentVC:BusinessTaskExpandedViewController!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TaskDescPopupView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        
    }
    
    //MARK: - Actions
    
    @IBAction func pressedDirectionsButton(_ sender: Any) {
        
    }
    
    @IBAction func pressedClosePopupButton(_ sender: Any) {
        parentVC.dismissedPopup()
        self.removeFromSuperview()
    }
}
