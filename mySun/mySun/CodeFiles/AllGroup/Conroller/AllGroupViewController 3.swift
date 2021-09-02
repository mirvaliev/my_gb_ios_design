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
    
    private var searchBarIsEmpty: Bool {
        guard let searchText = searchController.searchBar.text else { return false }
        return searchText.isEmpty
    }
    
    private var isFiltging: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // отображать результат поиска в том же View что и основной контент
    private let searchController = UISearchController(searchResultsController: nil)
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allGroupTableView.delegate = self
        allGroupTableView.dataSource = self
        allGroupArray = allGroupData.allGroup
        
        // настройка searchConroller
        searchController.searchResultsUpdater = self // получателем информации об изменеени текстов в поисковой строке является наш класс
        searchController.obscuresBackgroundDuringPresentation = false // что бы работь с поисковым контентом как с основным
        searchController.searchBar.placeholder = "Поиск ..." // пользовательское название
        
        navigationItem.searchController = searchController // отображаем строку поиска на NavigationBar
        definesPresentationContext = true // опускаем строку поиска при переходе на другой экран
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToViewSelectionGroupSegue" {
            if let indexPath = allGroupTableView.indexPathForSelectedRow {
                let allGroups: GroupsModel
                if isFiltging { allGroups = filterAllGroup[indexPath.row] } else { allGroups = allGroupArray[indexPath.row] }
            }
            
            let distanationVC = segue.destination
            guard let indexAllGroupCell = allGroupTableView.indexPathForSelectedRow?.row else { return }
            distanationVC.title = allGroupArray[indexAllGroupCell].groupName
        }
    }
}

extension AllGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltging { return filterAllGroup.count } else { return allGroupArray.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // активация строки поиска
        let allGroup: GroupsModel
        
        if isFiltging { allGroup = filterAllGroup[indexPath.row] } else { allGroup = allGroupArray[indexPath.row] }
        
        let allGroupCell = tableView.dequeueReusableCell(withIdentifier: AllGroupTableViewCell.indetifarAllGroup) as! AllGroupTableViewCell
        
        allGroupCell.configureAllGroup(groups: allGroupArray[indexPath.row])
        return allGroupCell
    }
}

extension AllGroupViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    // испрааавить для поиска
    private func filterContentForSearchText (searchText: String) {
        filterAllGroup = allGroupArray.filter({ (filer: GroupsModel) -> Bool in
            return filer.groupName.lowercased().contains(searchText.lowercased())
        })
        print(filterAllGroup)
        allGroupTableView.reloadData()
    }
}
