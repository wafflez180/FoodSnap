//
//  BusinessApplicationViewController.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/21/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit
import GooglePlaces

class BusinessApplicationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var addPhotoButton: UIButton!
    @IBOutlet var applyButton: UIButton!
    @IBOutlet var cancelButton: UIButton!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var locPinImageView: UIImageView!
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var phoneNumTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var locationTF: UITextField!
    @IBOutlet var commentsTextView: UITextView!
    
    let imagePicker = UIImagePickerController()
    var companyLogoImage:UIImage?
    var formattedLocAddress:String?
    var locCoordinates:CLLocationCoordinate2D?
    var placeID:String?
    var website:URL?
    var greenVerifiedColor:UIColor = UIColor.init(colorLiteralRed: 27/255, green: 188/255, blue: 156/255, alpha: 1.0)
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        setupUI()
        nameTF.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - BusinessApplicationViewController

    func setupUI(){
        setupImageView()
        setupTextFields()
    }
    
    func setupImageView(){
        addPhotoButton.layer.borderColor = UIColor.init(colorLiteralRed: 189/255, green: 189/255, blue: 189/255, alpha: 1.0).cgColor
        addPhotoButton.layer.borderWidth = 3.0
    }
    
    func setupTextFields(){
        nameTF.delegate = self
        nameTF.tag = 0
        phoneNumTF.delegate = self
        phoneNumTF.tag = 1
        emailTF.delegate = self
        emailTF.tag = 2
        locationTF.delegate = self
        locationTF.tag = 3
        
        commentsTextView.delegate = self
    }

    // MARK: - Actions

    @IBAction func pressedAddPhotoButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pressedApplyButton(_ sender: Any) {
        /*
         formattedLocAddress = place.formattedAddress
         locCoordinates = place.coordinate
         placeID
         website
         */
    }
    
    @IBAction func pressedCancelButton(_ sender: Any) {
        view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @IBAction func tappedScrollView(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    
    //https://stackoverflow.com/questions/31766896/switching-between-text-fields-on-pressing-return-key-in-swift
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
            
            if nextField.tag == 2 {
                let scrollPoint = CGPoint(x: 0, y: scrollView.contentSize.height/4)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            commentsTextView.becomeFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == locationTF {
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            present(autocompleteController, animated: true, completion: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTF && nameTF.text != "" {
            nameLabel.textColor = greenVerifiedColor
        }else if textField == phoneNumTF && (phoneNumTF.text?.characters.count)! >= 9 {
            phoneLabel.textColor = greenVerifiedColor
        }else if textField == emailTF && isValidEmail(testStr: emailTF.text!) {
            emailLabel.textColor = greenVerifiedColor
        }
    }
    
    // Helpers
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.characters.count > 0 {
            commentsLabel.textColor = greenVerifiedColor
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        companyLogoImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        addPhotoButton.layer.borderColor = greenVerifiedColor.cgColor
        addPhotoButton.setTitle("", for: UIControlState.normal)
        addPhotoButton.setBackgroundImage(companyLogoImage, for: UIControlState.normal)
        dismiss(animated:true, completion: nil)
    }
}

extension BusinessApplicationViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        formattedLocAddress = place.formattedAddress
        locCoordinates = place.coordinate
        placeID = place.placeID
        website = place.website
        locPinImageView.isHighlighted = true
        locationTF.text = place.formattedAddress
        locationLabel.textColor = greenVerifiedColor
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

