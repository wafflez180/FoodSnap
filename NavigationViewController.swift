//
//  NavigationViewController.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/20/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.tintColor = UIColor.init(colorLiteralRed: 27/255, green: 188/255, blue: 156/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueToInstagramUserPath(){
        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        self.pushViewController(homeViewController, animated:true)
    }
    
    func segueToBusinessUserPath(){
        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        self.pushViewController(homeViewController, animated:true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
