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
    }
    
    func configureView() {
        email.text = contact.emailAddress
        if let street = contact.address?.street, let zip = contact.address?.zipCode, let country = contact.address?.country, let city = contact.address?.city {

            address.text = "\(street)\n\(city), \(zip), \(country)"
        }
        birtdate.text = contact.birthdate
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
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
