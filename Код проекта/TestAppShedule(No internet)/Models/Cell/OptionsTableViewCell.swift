import UIKit
import FSCalendar
class OptionsTableViewCell:UITableViewCell{
    
    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.contentMode  = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameCellLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let repeatSwich:UISwitch =  {
        let swich = UISwitch()
        swich.isOn = true
        swich.isHidden = true
        
        swich.translatesAutoresizingMaskIntoConstraints = false
        return swich
    }()
    /*let addImageContact:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(systemName: "person.fill.badge.plus")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()*/
    weak var switchRepeatDelegate:SwitchRepeatProtocol?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        repeatSwich.addTarget(self, action: #selector(swichChange(paramTarget:)), for: .valueChanged)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impemented")
    }
    
    func cellScheduleConfigure(nameArray: [[String]], indexPath:IndexPath,hexColor: String){
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        repeatSwich.isHidden = (indexPath.section == 4 ? false : true)
        
        let color = UIColor().colorFromHex(hexColor)
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color : .white)
        repeatSwich.onTintColor = color
    }
    func cellTaskConfigure(nameArray:[String] ,indexPath:IndexPath, hexColor: String){
        nameCellLabel.text = nameArray[indexPath.section]
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 0.8049325501) : .white )
        
    }
    func cellContactConfigure(nameArray:[String] ,indexPath:IndexPath, image:UIImage?){
        nameCellLabel.text = nameArray[indexPath.section]
        if image == nil {
            indexPath.section == 4 ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus") : nil
        }else{
            indexPath.section == 4 ? backgroundViewCell.image = image : nil
            backgroundViewCell.contentMode = .scaleAspectFill
        }
        
        
    }
    @objc func swichChange(paramTarget:UISwitch){
        switchRepeatDelegate?.SwitchRepeate(value: paramTarget.isOn)
    }
    func setConstraints(){
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor,constant: 15),
        ])
        self.contentView.addSubview(repeatSwich)
        NSLayoutConstraint.activate([
            repeatSwich.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwich.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20)
        ])
       /* self.contentView.addSubview(addImageContact)
        NSLayoutConstraint.activate([
            addImageContact.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            addImageContact.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            addImageContact.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 0),
            addImageContact.bottomAnchor.constraint(equalTo: self.bottomAnchor,  constant: 0)
        ])*/
    }
}

