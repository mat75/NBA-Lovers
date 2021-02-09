import UIKit

class CustomTableView: UITableView {
    
    var addRefreshIndicator = true
    var refreshIndicator : UIRefreshControl =  {
        let rc = UIRefreshControl()
        return rc
    }()
    
    var refreschIndicationMessage = "Loading..." {
        didSet {
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.gray ,
                NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 15)!]
            refreshIndicator.attributedTitle = NSAttributedString(string: refreschIndicationMessage, attributes: attrs)
        }
    }
    
    var activityIndicator:UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        ai.color = .systemIndigo
        return ai
    }()
    
    var messageLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        l.textColor = UIColor.systemIndigo
        l.numberOfLines = 3
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews(){
        sectionIndexBackgroundColor = .clear
        self.backgroundColor = .clear
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.addSubview(messageLabel)
        messageLabel.isHidden = true
        messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: self.activityIndicator.topAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        messageLabel.widthAnchor.constraint(equalToConstant: 200 ).isActive = true
        
        if #available(iOS 10.0, *) {
            refreshControl = refreshIndicator
        } else {
            addSubview(refreshIndicator)
        }
        refreshIndicator.tintColor = .white

        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.gray ,
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 15)!]
        refreshIndicator.attributedTitle = NSAttributedString(string: refreschIndicationMessage, attributes: attrs)
        
    }
}
