import UIKit
import FSCalendar
class HeaderOptionsTableViewCell:UITableViewHeaderFooterView{
    
    
    let headerLabel  = UILabel(text: "", font: .avenirNext14(), alignment: .left)
    override init(reuseIdentifier:String?){
        super.init(reuseIdentifier:reuseIdentifier)
        headerLabel.textColor = UIColor(cgColor: #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1))
        self.contentView.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))
        setConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impemented")
    }
    func headerConfigure(nameArray:[String],section:Int){
        headerLabel.text = nameArray[section]
    }
    func setConstraints(){
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0)
        ])
    }
}


