//
//  AllGroupViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 14/08/21.
//

import UIKit

class AllGroupViewController: UIViewController {
    
    @IBOutlet var allGroupTableView: UITableView!
    
    private let allGroupData: GroupData = GroupData()
    var allGroupArray: [GroupsModel] = []
    private var filterAllGroup: [GroupsModel] = []
    
    private let searchAllController = UISearchController(searchResultsController: nil) // создаем экземпляр класса поиск
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchAllController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltring: Bool {
        return searchAllController.isActive && !searchBarIsEmpty
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allGroupTableView.delegate = self
        allGroupTableView.dataSource = self
        allGroupArray = allGroupData.allGroup
        filterAllGroup = allGroupData.allGroup
        createSearchBarAndController()
        
    }
    
    private func createSearchBarAndController() {
        searchAllController.searchBar.delegate = self
        searchAllController.searchResultsUpdater = self
        navigationItem.searchController = searchAllController // отображаем стороку поиска на стореборд
        searchAllController.searchBar.placeholder = "Все группы "
        searchAllController.searchBar.showsCancelButton =  true
        searchAllController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToViewSelectionGroupSegue" {
            let distanationVC = segue.destination
            guard
                let indexAllGroupCell = allGroupTableView.indexPathForSelectedRow?.row,
                let indexFilterAllGroupCell = allGroupTableView.indexPathForSelectedRow?.row
            else { return }
            if isFiltring {
                distanationVC.title = filterAllGroup[indexFilterAllGroupCell].groupName
            } else {
                distanationVC.title = allGroupArray[indexAllGroupCell].groupName
            }
        }
    }
}

extension AllGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltring { return filterAllGroup.count } else { return allGroupArray.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allGroupCell = tableView.dequeueReusableCell(withIdentifier: AllGroupTableViewCell.indetifarAllGroup) as! AllGroupTableViewCell
        
        if isFiltring { allGroupCell.configureAllGroup(groups:  filterAllGroup[indexPath.row]) }
        else { allGroupCell.configureAllGroup(groups: allGroupArray[indexPath.row]) }
        
        return allGroupCell
    }
    
}

extension AllGroupViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterAllGroup(searchT: searchController.searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
    
    private func filterAllGroup (searchT: String) {
        filterAllGroup = allGroupArray.filter({ (groupModel: GroupsModel) -> Bool in
            return groupModel.groupName.lowercased().contains(searchT.lowercased())
            
        })
        allGroupTableView.reloadData()
    }
}
    
