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
        
        let sidePadding:CGFloat = 20.0
        let sketchHeight:CGFloat = 220.0
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
        cameraManager.writeFilesToPhoneLibrary = false // TODO remember to turn this off
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
                let watermarkedImage = self.watermarkImage(backgroundImage: image!, watermarkImage: UIImage.init(named: "foodsnap-watermark")!)
                
                UIImageWriteToSavedPhotosAlbum(watermarkedImage, self, nil, nil)

                self.capturedImage = watermarkedImage
                self.cameraImageView.isHidden = true
                
                self.previewImageView.image = watermarkedImage
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
        let alert = UIAlertController(title: "Remember!", message: "Add the tags #moes #foodsnap so we can track the likes on your post!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            // called to post image with caption to the instagram application
            InstagramManager.sharedManager.postImageToInstagramWithCaption(imageInstagram: self.capturedImage!, instagramCaption: "This is a test with #tags #foodsnap", view: self.view)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Image Watermarking and Cropping
    
    func watermarkImage(backgroundImage: UIImage, watermarkImage: UIImage) -> UIImage {
        let croppedBGImage = cropToBounds(image: backgroundImage, width: Double((backgroundImage.cgImage?.width)!), height: Double((backgroundImage.cgImage?.width)!))
        
        UIGraphicsBeginImageContextWithOptions(croppedBGImage.size, false, 0.0)
        croppedBGImage.draw(in: CGRect(x: 0.0, y: 0.0, width: croppedBGImage.size.width, height: croppedBGImage.size.height))
        
        let multiplier:CGFloat = 8.0
        watermarkImage.draw(in: CGRect(x: croppedBGImage.size.width - (watermarkImage.size.width*multiplier), y: croppedBGImage.size.height - (watermarkImage.size.height*multiplier), width: (watermarkImage.size.width*multiplier), height: (watermarkImage.size.height*multiplier)))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result!
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX,y: posY, width: cgwidth,height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image:UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
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
