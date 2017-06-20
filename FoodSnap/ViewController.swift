//
//  ViewController.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/20/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var businessButton: UIButton!
    @IBOutlet var instagramButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupUI(){
        setupBusinessButton()
        setupInstagramButton()
    }
    
    func setupBusinessButton(){
        businessButton.layer.borderColor = UIColor.init(colorLiteralRed: 27/255, green: 188/255, blue: 156/255, alpha: 1.0).cgColor
        businessButton.layer.borderWidth = 2.0
    }
    
    func setupInstagramButton(){
        let gradient = CAGradientLayer()
        gradient.frame = instagramButton.bounds
        
        let orangeColor = UIColor.init(colorLiteralRed: 174/255, green: 35/255, blue: 35/255, alpha: 1.0).cgColor
        let purpleColor = UIColor.init(colorLiteralRed: 48/255, green: 35/255, blue: 174/255, alpha: 1.0).cgColor
        
        // Angles the gradient
        gradient.startPoint = CGPoint(x: 0, y: 1);
        gradient.endPoint = CGPoint(x: 1, y: 0);
        
        gradient.colors = [orangeColor, purpleColor]
        
        instagramButton.layer.insertSublayer(gradient, at: 0)
    }

    @IBAction func pressedInstagramButton(_ sender: Any) {
        let navigationViewController = NavigationViewController(nibName: "NavigationViewController", bundle: nil)
        self.present(navigationViewController, animated:true, completion:nil)
    }
}

