

import UIKit

class CustomTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
                static let reuseIdentifer = "CustomHeaderReuseIdentifier"
                let customLabel = UILabel.init()
                
                override public init(reuseIdentifier: String?) {
                    super.init(reuseIdentifier: reuseIdentifier)
                    
                    customLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
                    customLabel.textColor = .white
                    self.backgroundColor = .dirtyWhite
                    self.tintColor = .systemIndigo
                    customLabel.contentMode = .bottom

                    
                    customLabel.translatesAutoresizingMaskIntoConstraints = false
                    self.contentView.addSubview(customLabel)
                    
                    let margins = contentView.layoutMarginsGuide
                    customLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
                    customLabel.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
                    customLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant:  -5).isActive = true
                    customLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
                }
                
                required init?(coder aDecoder: NSCoder) {
                    fatalError("init(coder:) has not been implemented")

            }   

}

