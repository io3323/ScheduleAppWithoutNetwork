import UIKit
extension UIAlertController{
    func negativeWidtConsraint(){
        for subView in self.view.subviews{
            for constraints in subView.constraints where constraints.debugDescription.contains("width == - 16"){
                subView.removeConstraint(constraints)
            }
        }
    }
}
