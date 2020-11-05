//
//  ContactDetailViewController.swift
//  agendaiOS
//
//  Created by Alejandro de jesus on 03/11/2020.
//  Copyright © 2020 Alejandro de jesus. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var contacts:[Contact] = []
    var contact = Contact()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var homePhone: UILabel!
    @IBOutlet weak var mobilePhone: UILabel!
    @IBOutlet weak var workPhone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var birtdate: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title = "Contacts"
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setRightBarButton()
    }
    
    func configureView() {
        email.text = contact.emailAddress
        nameLabel.text = contact.name
        companyName.text = contact.companyName
        
        if let street = contact.address?.street, let zip = contact.address?.zipCode, let country = contact.address?.country, let city = contact.address?.city {
            address.text = "\(street)\n\(city), \(zip), \(country)"
        }
        
        let dateToPrint = "\(contact.birthdate ?? "") 00:00:00"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: dateToPrint) {
            birtdate.text = dateFormatterPrint.string(from: date)
        } else {
            birtdate.text = contact.birthdate
        }
        
        if !(contact.largeImageURL?.isEmpty ?? false) {
            do {
                guard let image = contact.largeImageURL else { return }
                let url = URL(string: image)
                let data = try Data(contentsOf: url!)
                contactImage.image = UIImage(data: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        workPhone.text = formatPhone(with: "(XXX) XXX-XXXX", phone: contact.phone?.work ?? "")
        homePhone.text = formatPhone(with: "(XXX) XXX-XXXX", phone: contact.phone?.home ?? "")
        mobilePhone.text = formatPhone(with: "(XXX) XXX-XXXX", phone: contact.phone?.mobile ?? "")
    }
    
    func formatPhone(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    func setRightBarButton() {
        let image = contact.isFavorite ?? false ? "Favorite — True" : "Favorite — False"
        
        let extraInfoBtn = UIBarButtonItem(image: UIImage(named: image), landscapeImagePhone: UIImage(named: image), style: UIBarButtonItem.Style.done, target: self, action: #selector(touchUpInsideInfoBtn(_:)))
        extraInfoBtn.tintColor = UIColor.init(red: 255/255, green: 210/255, blue: 120/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = extraInfoBtn
    }
    
    @objc func touchUpInsideInfoBtn(_ barButtonItem: UIBarButtonItem) {
        contact.isFavorite = !(contact.isFavorite ?? false)
        setRightBarButton()
        for contactCurrent in contacts {
            var index = 0
            if contact.id == contactCurrent.id {
                contacts[index].isFavorite = contact.isFavorite
            }
            index += 1
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let vc = ContactsViewController()
        vc.contacts = contacts
    }
}
