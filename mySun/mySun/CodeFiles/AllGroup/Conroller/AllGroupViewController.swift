//
//  AllGroupViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 14/08/21.
//

import UIKit

class AllGroupViewController: UIViewController {
    
    @IBOutlet var allGroupTableView: UITableView!
    
    
    
    let allGroupData: GroupData = GroupData()
    var allGroupArray: [GroupsModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allGroupArray = allGroupData.allGroup
        
        allGroupTableView.delegate = self
        allGroupTableView.dataSource = self
        
        
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToViewSelectionGroupSegue" {
            let distanationVC = segue.destination
            guard let indexAllGroupCell = allGroupTableView.indexPathForSelectedRow?.row else { return }
            distanationVC.title = allGroupArray[indexAllGroupCell].groupName
        }
    }
}

extension AllGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroupArray.count // скоолько секций в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allGroupCell = tableView.dequeueReusableCell(withIdentifier: AllGroupTableViewCell.indetifarAllGroup) as! AllGroupTableViewCell
        
        allGroupCell.configureAllGroup(groups: allGroupArray[indexPath.row])
        return allGroupCell
    }
}

