//
//  CreateTaskViewController.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/22/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var prizeLabel: UILabel!
    @IBOutlet var expirationLabel: UILabel!
    
    @IBOutlet var goalTF: UITextField!
    @IBOutlet var tagTF: UITextField!
    @IBOutlet var noteTextView: UITextView!
    @IBOutlet var prizeTF: UITextField!
    @IBOutlet var expirationTF: UITextField!
    
    var greenVerifiedColor:UIColor = UIColor.init(colorLiteralRed: 27/255, green: 188/255, blue: 156/255, alpha: 1.0)
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        goalTF.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - CreateTaskViewController

    func setupUI(){
        setupTextFields()
    }
    
    func setupTextFields(){
        goalTF.delegate = self
        goalTF.tag = 0
        tagTF.delegate = self
        tagTF.tag = 1
        prizeTF.delegate = self
        prizeTF.tag = 2
        expirationTF.delegate = self
        expirationTF.tag = 3
        
        noteTextView.delegate = self
    }

    
    // MARK: - Actions

    @IBAction func pressedCancelButton(_ sender: Any) {
        view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @IBAction func pressedSendOutButton(_ sender: Any) {
        
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
            
            if nextField.tag == 2 {
                let scrollPoint = CGPoint(x: 0, y: scrollView.contentSize.height/5)
                scrollView.setContentOffset(scrollPoint, animated: true)
                noteTextView.becomeFirstResponder()
            }else{
                nextField.becomeFirstResponder()
            }
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == goalTF && goalTF.text != "" && goalTF.text!.isNumeric {
            goalLabel.textColor = greenVerifiedColor
        }else if textField == tagTF && tagTF.text != "" {
            tagLabel.textColor = greenVerifiedColor
        }else if textField == prizeTF && prizeTF.text != "" {
            prizeLabel.textColor = greenVerifiedColor
        }else if textField == expirationTF && expirationTF.text != "" && goalTF.text!.isNumeric {
            expirationLabel.textColor = greenVerifiedColor
        }
    }
    
    // MARK: - UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            prizeTF.becomeFirstResponder()
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.characters.count > 0 {
            noteLabel.textColor = greenVerifiedColor
        }
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
