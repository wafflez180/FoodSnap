//
//  BusinessHomeViewController.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/21/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit

class BusinessHomeViewController: UIViewController {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumLabel: UILabel!
    
    @IBOutlet var changeInfoButton: UIButton!
    @IBOutlet var createTaskButton: UIButton!
    @IBOutlet var taskRequestsButton: UIButton!
    
    @IBOutlet var taskTableView: UITableView!
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - BusinessHomeViewController
    
    func setupUI(){
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        self.title = "FoodSnap Business"
        
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout-icon", in: nil, compatibleWith: nil), style: UIBarButtonItemStyle.done, target: self, action: #selector(pressedLogoutButton))
        
        self.navigationItem.leftBarButtonItem = logoutButton
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Selectors
    
    func pressedLogoutButton(){
        self.dismiss(animated: true) { 
            
        }
        //TODO call to API
    }
    
    // MARK: - Actions
    
    @IBAction func pressedChangeInfoButton(_ sender: Any) {
    }

    
    @IBAction func pressedCreateTaskButton(_ sender: Any) {
        let createTaskViewCont = CreateTaskViewController(nibName: "CreateTaskViewController", bundle: nil)
        self.present(createTaskViewCont, animated:true)
    }
    
    @IBAction func pressedTaskRequestButton(_ sender: Any) {
        
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
