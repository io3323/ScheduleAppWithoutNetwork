import UIKit
extension  UIViewController{
    func alertForCellName(label: UILabel, name:String, placeholder:String, competionHandler:@escaping (String) -> Void){
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else {return}
            label.text = (text != "" ? text : label.text)
            competionHandler(text)
        }
        alert.addTextField { (tfAlert) in
            tfAlert.placeholder =  placeholder
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        //Опцианальный алерт фикс ошибки
        alert.negativeWidtConsraint()
        present(alert, animated: true, completion: nil)
    }
}
