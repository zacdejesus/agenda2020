//
//  ContactTableViewCell.swift
//  agendaiOS
//
//  Created by Alejandro de jesus on 03/11/2020.
//  Copyright © 2020 Alejandro de jesus. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ contact: Contact) {
        do {
            guard let image = contact.smallImageURL else { return }
            let url = URL(string: image)
            let data = try Data(contentsOf: url!)
            contactImage.image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        if contact.isFavorite ?? false {
            starImage.image = UIImage(imageLiteralResourceName: "Favorite — True")
        }
        nameLabel.text = contact.name
        companyLabel.text = contact.companyName
    }
}
