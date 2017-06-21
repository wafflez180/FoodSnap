//
//  HomeViewController.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/20/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var taskScrollView: UIScrollView!
    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var taskCells: [BusinessTaskView] = []
    var currentTaskIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        setupMap()
        setupTasks()
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        self.title = "FoodSnap"
        
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout-icon", in: nil, compatibleWith: nil), style: UIBarButtonItemStyle.done, target: self, action: #selector(pressedLogoutButton))
        
        let sharedPostsButton = UIBarButtonItem(image: UIImage(named: "shared-photos-icon", in: nil, compatibleWith: nil), style: UIBarButtonItemStyle.plain, target: self, action: #selector(pressedSharedPhotosButton))

        self.navigationItem.leftBarButtonItem = logoutButton
        self.navigationItem.rightBarButtonItem = sharedPostsButton
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    func setupMap(){
        mapView.delegate = self
        setupLocation()
        mapView.showsUserLocation = true
    }
    
    func setupTasks(){
        var seperatorPadding:CGFloat = 0.0
        var newContentSize:CGFloat = 0.0
        
        let taskView = BusinessTaskView.instanceFromNib() as! BusinessTaskView
        taskView.parentVC = self
        var newFrame = taskView.frame
        newFrame.size.width = taskScrollView.frame.width
        taskView.frame = newFrame
        taskScrollView.addSubview(taskView)
        newContentSize+=newFrame.size.width
        taskCells.append(taskView)
        
        let taskView2 = BusinessTaskView.instanceFromNib() as! BusinessTaskView
        taskView2.parentVC = self
        var newFrame2 = taskView2.frame
        newFrame2.origin.x = taskScrollView.frame.width + 1
        newFrame2.size.width = taskScrollView.frame.width
        taskView2.frame = newFrame2
        taskScrollView.addSubview(taskView2)
        seperatorPadding+=1.0
        newContentSize+=newFrame2.size.width
        taskCells.append(taskView2)
        
        taskScrollView.contentSize = CGSize(width: newContentSize + seperatorPadding, height: 0)
    }
    
    func setupLocation(){
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - MapView Delegate
    
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.location!.coordinate.latitude, longitude: userLocation.location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: false)
    }

    // MARK: - Actions
    
    @IBAction func pressedNextTaskButton(_ sender: Any) {
        currentTaskIndex+=1
        if currentTaskIndex >= taskCells.count {
            currentTaskIndex = 0
        }
        taskScrollView.setContentOffset(taskCells[currentTaskIndex].frame.origin, animated: true)
    }
    
    // MARKL - Selectors
    
    func pressedLogoutButton(){
        self.dismiss(animated: true) {
            
        }
        //TODO call to API
    }
    
    func pressedSharedPhotosButton(){
        let sharedPhotosTableViewCont = SharedPhotosTableViewController(nibName: "SharedPhotosTableViewController", bundle: nil)
        self.navigationController?.pushViewController(sharedPhotosTableViewCont, animated:true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
