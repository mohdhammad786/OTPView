import Foundation
import UIKit
protocol TextFieldBehaviourDelegate {
    func onTapClearButton()
}
open class BigOHTextField:UITextField {
    
    var keyboardBehaviour:TextFieldKeyBoardBehaviourInterface? {
        didSet {
            self.delegate = self.keyboardBehaviour
        }
    }
    var keyBoardCancelDelegate:TextFieldBehaviourDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public override  func awakeFromNib() { // for storyboard only i think
        super.awakeFromNib()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public override func deleteBackward() {
        guard let length:Int = self.text?.count else {return}
        if(length == 0) {
            self.keyBoardCancelDelegate?.onTapClearButton()
        }
        super.deleteBackward()
    }
}





