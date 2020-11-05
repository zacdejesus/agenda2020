//
//  ViewController.swift
//  agendaiOS
//
//  Created by Alejandro de jesus on 02/11/2020.
//  Copyright © 2020 Alejandro de jesus. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let contactService = agendaService()
    var contacts:[Contact] = []
    var favoriteContacts:[Contact] = []
    var otherContacts:[Contact] = []
    var indexContact = 0
    var isFavorite = true
    
    @IBOutlet weak var agendaTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        sortContacts(contacts)
        agendaTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView()
        agendaTableView.delegate = self
        agendaTableView.dataSource = self
        agendaTableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        fetchData()
    }
    
    func fetchData() {
        contactService.getContacts(success: { [weak self] (result) in
            self?.contacts = result.sorted { $0.name ?? "" < $1.name ?? "" }
            
            if let contacts = self?.contacts {
                self?.sortContacts(contacts)
            }
            
            self?.agendaTableView.reloadData()
            self?.dismiss(animated: false, completion: nil)
            })
        {() in
            self.dismiss(animated: false, completion: nil)
            let alert = UIAlertController(title: "Error", message: "there has been an error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "reload", style: .default, handler: { action in
            }))
            self.fetchData()
        }
    }
    func loadingView() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func sortContacts(_ array: [Contact]) {
        favoriteContacts.removeAll()
        otherContacts.removeAll()
        for currentContact in array {
            if currentContact.isFavorite ?? false {
                favoriteContacts.append(currentContact)
            }else {
                otherContacts.append(currentContact)
            }
        }
    }
}

extension ContactsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favoriteContacts.count
        } else {
            return otherContacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as? ContactTableViewCell {

                if indexPath.section == 0 {
                    cell.configureCell(self.favoriteContacts[indexPath.row])
                } else {
                    cell.configureCell(self.otherContacts[indexPath.row])
                }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.text = section == 0 ? "FAVORITE CONTACTS" : "OTHER CONTACTS"
        return label
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexContact = indexPath.row
        isFavorite = indexPath.section == 0 ? true : false
        indexContact = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ContactDetailViewController {
            vc.contacts = contacts
            if isFavorite {
                vc.contact = favoriteContacts[indexContact]
            } else {
                vc.contact = otherContacts[indexContact]
            }
        }
    }
}

