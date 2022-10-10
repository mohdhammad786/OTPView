import Foundation
import UIKit
public protocol OTPViewCompletionDelegate {
    func userEnteredTheOtp(combinedOtp:String)
}
open class OTPView:UIView{
    var stackView:UIStackView!
    var currentTextField:BigOHTextField?
    var numberOfBoxes:Int = 0
    open var otpCompletionDelegate:OTPViewCompletionDelegate?
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public override  func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupKeyBoardBehaviourDelegate() {
        for textField in stackView.subviews{
            guard let textField = textField as? BigOHTextField else {return}
            textField.keyBoardCancelDelegate = self
        }
    }
    private func setupUI() {
        stackView = UIStackView(frame: self.bounds)
        setupStackView()
        self.addSubview(stackView)
    }
    private func setupStackView() {
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.spacing = 20
    }
    open func setNumberOfBoxes(number:Int) {
        for view in stackView.subviews{
            view.removeFromSuperview()
        }
        for i in 1...number {
            let generatedTextField = BigOHTextField()
            generatedTextField.keyboardType = .numberPad
            if(i>1) {
                generatedTextField.isUserInteractionEnabled = false
            }
            generatedTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
            generatedTextField.keyboardBehaviour = TextFieldKeyboardBehaviourFactory.createTextFieldBehaviour(textFieldType: .numbers, maxCount: 1, textField: generatedTextField)
            generatedTextField.textAlignment = .center
            generatedTextField.backgroundColor = .black
            stackView.addArrangedSubview(generatedTextField)
            setupKeyBoardBehaviourDelegate()
        }
        stackView.subviews.first?.becomeFirstResponder()
        self.currentTextField = (stackView.subviews.first) as? BigOHTextField
        numberOfBoxes = number
    }
    open func changeBackgroundColor(color:UIColor) {
        for textField in stackView.subviews{
            textField.backgroundColor = color
        }
    }
    open func setTextFieldFont(font:UIFont) {
        for textField in stackView.subviews{
            (textField as? UITextField)?.font = font
        }
    }
    open func setTextFieldTextColor(color:UIColor) {
        for textField in stackView.subviews{
            (textField as? UITextField)?.textColor = color
        }
    }
    open func getCombinedOTP() ->String {
        var finalOTP:String = ""
        for textField in stackView.subviews{
            guard let strongTextField  = (textField as? UITextField)?.text else {return ""}
            finalOTP = finalOTP + strongTextField
        }
        return finalOTP
    }
    @objc func textFieldChanged(sender:UITextField) {
        guard let count = sender.text?.count else {return}
        if(count != 0) {
            let index = stackView.subviews.firstIndex(of: sender)
            guard let index = index else {return}
            if(index == numberOfBoxes-1) {
                otpCompletionDelegate?.userEnteredTheOtp(combinedOtp: getCombinedOTP())
            }
            let secondLastIndex = numberOfBoxes - 2
            if (index<=secondLastIndex) {
                let nextTextField = stackView.subviews[index+1]
                nextTextField.isUserInteractionEnabled = true
                sender.isUserInteractionEnabled = false
                currentTextField = nextTextField as? BigOHTextField
                nextTextField.becomeFirstResponder()
            }
        }
    }
    open func setStackSpacing(spacing:CGFloat) {
        self.stackView.spacing = spacing
    }
    open func setTextFieldCornerRadius(cornerRadius:CGFloat) {
        for view in stackView.subviews {
            view.layer.cornerRadius = cornerRadius
        }
    }
    open func setTextFieldBorder(borderWidth:CGFloat,borderColor:CGColor) {
        for view in stackView.subviews {
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = borderColor
        }
    }
}
extension OTPView:TextFieldBehaviourDelegate {
    func onTapClearButton() {
        guard let strongCurrentTextField = currentTextField else {return}
        let index = stackView.subviews.firstIndex(of: strongCurrentTextField)
        guard let index = index else {return}
        if(index>0) {
            strongCurrentTextField.isUserInteractionEnabled = false
        }
        if (index-1 >= 0) {
            let previousTextField = stackView.subviews[index-1]
            guard let  prev = previousTextField as? BigOHTextField else {return}
            prev.text = ""
            previousTextField.isUserInteractionEnabled = true
            currentTextField  = previousTextField as? BigOHTextField
            previousTextField.becomeFirstResponder()
        }
    }
}


