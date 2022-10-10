import Foundation
import UIKit
enum TextFieldBehaviourTypes {
    case allCharacters
    case specialCharacters
    case numbers
    case letters
}
protocol TextFieldKeyBoardBehaviourInterface :UITextFieldDelegate{
    var maxAllowedCharacters:Int {get set}
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}

public class TextFieldKeyboardBehaviourFactory {
    static func createTextFieldBehaviour(textFieldType:TextFieldBehaviourTypes,maxCount:Int,textField:UITextField) ->TextFieldKeyBoardBehaviourInterface {
        switch textFieldType {
        case .allCharacters:
            return TextFieldAllCharacterBehaviour(maxCount:maxCount , textField: textField)
        case .specialCharacters:
            return TextFieldSpecialCharacterBehaviour(maxCount: maxCount, textField: textField)
        case .numbers:
            return TextFieldNumberBehaviour(maxCount: maxCount, textField: textField)
        case .letters:
            return TextFieldOnlyLetterBehaviour(maxCount: maxCount, textField: textField)
        }
    }
}

public class TextFieldAllCharacterBehaviour: NSObject, TextFieldKeyBoardBehaviourInterface{
    weak var myTextFieldReference:UITextField?
    var maxAllowedCharacters: Int = 0
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = maxAllowedCharacters
        let currentString: NSString = (myTextFieldReference?.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
       
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) &&  newString.length <= maxLength
    }
    init(maxCount: Int, textField : UITextField) {
        self.myTextFieldReference = textField
        self.maxAllowedCharacters = maxCount
    }
}
class TextFieldSpecialCharacterBehaviour:NSObject,TextFieldKeyBoardBehaviourInterface {
    weak var myTextFieldReference: UITextField?
    var maxAllowedCharacters: Int = 0
    init(maxCount: Int, textField : UITextField) {
        self.myTextFieldReference = textField
        self.maxAllowedCharacters = maxCount
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = maxAllowedCharacters
        let currentString: NSString = (myTextFieldReference?.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        let acceptableCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
        let allowedCharacters = NSCharacterSet(charactersIn: acceptableCharacters).inverted
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) &&  newString.length <= maxLength
    }
    
}

class TextFieldNumberBehaviour:NSObject,TextFieldKeyBoardBehaviourInterface {
    weak var myTextFieldReference: UITextField?
    var maxAllowedCharacters: Int = 0
    init(maxCount: Int, textField : UITextField) {
        self.myTextFieldReference = textField
        self.maxAllowedCharacters = maxCount
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = maxAllowedCharacters
        let currentString: NSString = (myTextFieldReference?.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) &&  newString.length <= maxLength
    }
}
class TextFieldOnlyLetterBehaviour:NSObject,TextFieldKeyBoardBehaviourInterface {
    weak var myTextFieldReference: UITextField?
    var maxAllowedCharacters: Int = 0
    init(maxCount: Int, textField : UITextField) {
        self.myTextFieldReference = textField
        self.maxAllowedCharacters = maxCount
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = maxAllowedCharacters
        let currentString: NSString = (myTextFieldReference?.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) &&  newString.length <= maxLength
    }
    
}



