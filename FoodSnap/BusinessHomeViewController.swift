//
//  BusinessHomeViewController.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/21/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit

class BusinessHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumLabel: UILabel!
    
    @IBOutlet var changeInfoButton: UIButton!
    @IBOutlet var createTaskButton: UIButton!
    @IBOutlet var taskRequestsButton: UIButton!
    
    @IBOutlet var taskTableView: UITableView!
    @IBOutlet var contentView: UIView!
    
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
        setupTableView()
    }
    
    func setupTableView(){
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.register(UINib(nibName: "BusinessTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "businessTaskReuseIdentifier")
        taskTableView.tableFooterView = UIView()
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
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessTaskReuseIdentifier", for: indexPath) as! BusinessTaskTableViewCell
        
        return cell
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
