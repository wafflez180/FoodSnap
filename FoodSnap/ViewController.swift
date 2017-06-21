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

    // MARK: - Actions
    
    @IBAction func pressedInstagramButton(_ sender: Any) {
        let navigationViewController = NavigationViewController(nibName: "NavigationViewController", bundle: nil)
        self.present(navigationViewController, animated:true, completion:nil)
        navigationViewController.segueToInstagramUserPath()
    }
    
    @IBAction func pressedBusinessButton(_ sender: Any) {
        let alert = UIAlertController(title: "Do you own a business?", message: "You can apply for an account here. You will be able to post local tasks to help grow your business!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Appy", style: UIAlertActionStyle.default, handler: { action in
            let businessApplicationCont = BusinessApplicationViewController(nibName: "BusinessApplicationViewController", bundle: nil)
            self.present(businessApplicationCont, animated:true)
        }))

        alert.addAction(UIAlertAction(title: "Sign In", style: UIAlertActionStyle.default, handler: { action in
            self.presentBusinessSignIn()
        }))

        alert.addAction(UIAlertAction(title: "No, Thanks", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Helpers
    
    func presentBusinessSignIn(){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "FoodSnap Business", message: "Enter your username and password (check your email if you don't know)", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { [weak alert] (_) in
            let userNameTF = alert?.textFields![0]
            let passwordTF = alert?.textFields![0]
            //TODO CONNECT TO API
            let navigationViewController = NavigationViewController(nibName: "NavigationViewController", bundle: nil)
            self.present(navigationViewController, animated:true, completion:nil)
            navigationViewController.segueToBusinessUserPath()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)

    }
}

