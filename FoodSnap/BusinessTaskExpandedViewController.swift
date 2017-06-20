//
//  BusinessTaskExpandedViewController.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/20/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit
import CameraManager

class BusinessTaskExpandedViewController: UIViewController {
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var previewImageView: UIImageView!
    
    @IBOutlet var retakePhotoButton: UIButton!
    @IBOutlet var exitInstaButton: UIButton!
    @IBOutlet var capturePhotoButton: UIButton!
    
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet var companyImageView: UIImageView!
    
    let cameraManager = CameraManager()
    var capturedImage:UIImage?
    
    // MARK: - View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let popup = TaskDescPopupView.instanceFromNib() as! TaskDescPopupView
        popup.parentVC = self
        
        var sidePadding:CGFloat = 20.0
        var sketchHeight:CGFloat = 220.0
        popup.frame = CGRect(x: 20.0, y: (self.view.frame.size.height/2.0) - (sketchHeight/2.0), width: self.view.frame.size.width - (sidePadding * 2.0), height: sketchHeight)
        
        self.view.addSubview(popup)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Business Task Expanded View Controller
    
    func setupUI(){
        setupCamera()
        setupImageView()
        setupForPopup()
        
        self.previewImageView.isHidden = true
        retakePhotoButton.isHidden = true
        exitInstaButton.isHidden = true
    }
    
    func setupForPopup(){
        capturePhotoButton.isEnabled = false
        capturePhotoButton.alpha = 0.25
    }
    
    func dismissedPopup(){
        capturePhotoButton.isEnabled = true
        UIView.animate(withDuration: 0.5) {
            self.capturePhotoButton.alpha = 1.0
            self.visualEffectView.alpha = 0.0
        }
    }
    
    func setupCamera(){
        cameraManager.addPreviewLayerToView(cameraImageView)
        cameraManager.cameraDevice = .back
        cameraManager.shouldEnableTapToFocus = true
        cameraManager.shouldEnablePinchToZoom = true
        cameraManager.cameraOutputMode = .stillImage
        cameraManager.cameraOutputQuality = .high
        cameraManager.focusMode = .continuousAutoFocus
        cameraManager.exposureMode = .continuousAutoExposure
        cameraManager.flashMode = .off
        cameraManager.animateShutter = true
        cameraManager.animateCameraDeviceChange = false
        cameraManager.showAccessPermissionPopupAutomatically = true
    }
    
    func setupImageView(){
        companyImageView.layer.borderColor = UIColor.init(colorLiteralRed: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        companyImageView.layer.borderWidth = 1.0
    }
    
    // MARK: - Actions
    
    @IBAction func pressedDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedCameraButton(_ sender: Any) {
        if previewImageView.isHidden {
            cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
                self.capturedImage = image
                self.cameraImageView.isHidden = true
                
                self.previewImageView.image = image
                self.previewImageView.isHidden = false
                self.retakePhotoButton.isHidden = false
                self.exitInstaButton.isHidden = false
            })
        }
    }
    
    @IBAction func pressedRetakePhotoButton(_ sender: Any) {
        self.previewImageView.isHidden = true
        self.retakePhotoButton.isHidden = true
        self.exitInstaButton.isHidden = true
        self.cameraImageView.isHidden = false
    }
    
    @IBAction func pressedExitToInstaButton(_ sender: Any) {
        // called to post image with caption to the instagram application
        InstagramManager.sharedManager.postImageToInstagramWithCaption(imageInstagram: capturedImage!, instagramCaption: "This is a test with #tags #foodsnap", view: self.view)
        // TODO Go to instagram with picture and caption
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
