//
//  AllGroupViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 14/08/21.
//

import UIKit

class AllGroupViewController: UIViewController {

    
    @IBOutlet var allGroupTableView: UITableView!
    
    let allGroupArray = ["Фотография", "Программирование", "История", "Релгия"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allGroupTableView.delegate = self
        allGroupTableView.dataSource = self
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToViewSelectionGroupSegue" {
            let distanationVC = segue.destination
            guard let indexAllGroupCell = allGroupTableView.indexPathForSelectedRow?.row else { return }
            distanationVC.title = allGroupArray[indexAllGroupCell]
        }
    }
}

extension AllGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroupArray.count // скоолько секций в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allGroupCell = tableView.dequeueReusableCell(withIdentifier: AllGroupTableViewCell.indetifarAllGroup) as! AllGroupTableViewCell
        allGroupCell.configureAllGroup(avatarLogoName: "photo", lableName: allGroupArray[indexPath.row])
        return allGroupCell
    }
}
