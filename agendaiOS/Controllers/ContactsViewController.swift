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
    var indexContact = 0
    
    @IBOutlet weak var agendaTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agendaTableView.delegate = self
        agendaTableView.dataSource = self
        agendaTableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        fetchData()
    }
    
    func fetchData() {
        contactService.getContacts(success: { [weak self] (result) in
            self?.contacts = result
            self?.agendaTableView.reloadData()
            })
        {() in
            
        }
    }
}

extension ContactsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as? ContactTableViewCell {
            cell.configureCell(contacts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexContact = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ContactDetailViewController {
            vc.contacts = contacts
            vc.contact = contacts[indexContact]
        }
    }
}

