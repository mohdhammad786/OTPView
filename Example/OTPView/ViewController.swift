//
//  ViewController.swift
//  OtpPod
//
//  Created by Mohd Hammad Siddiqui on 27/09/22.
//

import UIKit
import OTPView
class ViewController: UIViewController {
    @IBOutlet weak var otp:OTPView!
    @IBOutlet weak var label:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Enter the otp "
        otp.otpCompletionDelegate = self
        otp.setNumberOfBoxes(number: 4)
        otp.changeBackgroundColor(color: .black)
        otp.setTextFieldTextColor(color: UIColor.white)
        otp.setTextFieldCornerRadius(cornerRadius: 20)
        otp.setTextFieldBorder(borderWidth: 3, borderColor: UIColor.gray.cgColor)
        otp.setStackSpacing(spacing: 10)
    }
}
extension ViewController:OTPViewCompletionDelegate {
    func userEnteredTheOtp(combinedOtp: String) {
        print(combinedOtp)
        self.label.text = "Your enetered otp is \(combinedOtp)"
    }
    
    
}


