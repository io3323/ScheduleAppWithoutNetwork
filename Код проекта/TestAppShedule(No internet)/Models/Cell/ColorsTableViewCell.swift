import UIKit
import FSCalendar
class ColorsTableViewCell:UITableViewCell{
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let cellNameArray  = [["Date","Time"],
                          ["Name","Type","Building","Audienxe"],
                          ["Teacher Name"],
                          [""],
                          ["Repeat every 7 days"]]
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impemented")
    }
    
    func cellConfigure(indexPath:IndexPath){
        switch indexPath.section {
        case 0:
            backgroundViewCell.backgroundColor = UIColor(cgColor: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))
        case 1:
            backgroundViewCell.backgroundColor = UIColor(cgColor: #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))
        case 2:
            backgroundViewCell.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1))
        case 3:
            backgroundViewCell.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1))
        case 4:
            backgroundViewCell.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1))
        case 5:
            backgroundViewCell.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1))
        case 6:
            backgroundViewCell.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1))
        default:
            backgroundViewCell.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        }
    }
    func setConstraints(){
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
    }
}

