//
//  MyGroupViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 14/08/21.
//

import UIKit

class MyGroupViewController: UIViewController {

    @IBOutlet var myGroupTableView: UITableView!
    
    private let myGroupData: GroupData = GroupData()
    private var myGroupArray: [GroupsModel] = []
    private var filterMyGroup: [GroupsModel] = []
    
    
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
        
        myGroupTableView.delegate = self
        myGroupTableView.dataSource = self
        myGroupArray = myGroupData.myGroup
        filterMyGroup = myGroupData.myGroup
        createSearchBarAndController()
    }
    
    private func createSearchBarAndController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController // отображаем стороку поиска на стореборд
        searchController.searchBar.placeholder = "Все группы "
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        searchController.searchBar.setShowsCancelButton(true, animated: true)
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToViewSelectionGroupSegue" {
            guard
                let distanationVC = segue.destination as? MyGroupCollectionViewController,
                let indexAllGroupCell = myGroupTableView.indexPathForSelectedRow?.row
            else { return }
            
            let selectGroup = myGroupArray[indexAllGroupCell]
            distanationVC.title = selectGroup.groupName
            distanationVC.myGroupPhoto = selectGroup.groupPhoto
        } else if segue.identifier == "ToPhotoVc" {
            let photoVC = segue.destination as! MyGroupCollectionViewController
            guard let index = myGroupTableView.indexPathForSelectedRow else { return }
            photoVC.myGroupPhoto = myGroupArray[index.row].groupPhoto
        }
        
    }
    
    @IBAction func addGroupsInMyGroups (_ segue: UIStoryboardSegue) {
        guard let sourseController = segue.source as? AllGroupViewController,
              let indexSelectionCell = sourseController.allGroupTableView.indexPathForSelectedRow
            else { return }
        
        //получаем название группы из массива всех групп
        let groups = sourseController.allGroupArray[indexSelectionCell.row]
        let searchGroup = sourseController.filterAllGroup[indexSelectionCell.row]
                
        // проверяем если группа не содержиться то добавляем
        // В этом замыкании вы сравнивате имя одной группы с именем другой группы. в $0 поочереди приходят группы из вашего массива в контроллере Мои группы у которых затем отбираются имена , а первое значение groups.groupName мы получили из контроллера со всеми группами.
        if isFiltging {
            if !filterMyGroup.contains(where: { groups.groupName == $0.groupName }) {
                myGroupArray.append(searchGroup)
            }
        } else {
            if !myGroupArray.contains(where: { groups.groupName == $0.groupName }) {
                myGroupArray.append(groups)
            }
        }
        
        
                
        // После того как добавили то надо перезагрузить таблицу
        myGroupTableView.reloadData()
    }
}

extension MyGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltging { return filterMyGroup.count } else { return myGroupArray.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myGroupCell = tableView.dequeueReusableCell(withIdentifier: MyGroupTableViewCell.indetifarMyGroup) as! MyGroupTableViewCell
        if isFiltging { myGroupCell.configureMyGroup(groups: filterMyGroup[indexPath.row]) } else { myGroupCell.configureMyGroup(groups: myGroupArray[indexPath.row]) }
        return myGroupCell
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteGroupAction = deleteGroupAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [deleteGroupAction])
    }
    
    func deleteGroupAction (at indexPath: IndexPath) -> UIContextualAction {
        let actionDelGroup = UIContextualAction(style: .destructive, title: nil) { actionDel, view, complaction in
            //удаляем группу из масива
            self.myGroupArray.remove(at: indexPath.row)
            // удаляем строку из таблицы
            self.myGroupTableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        actionDelGroup.backgroundColor = .red
        actionDelGroup.image = UIImage(systemName: "trash.fill")
        return actionDelGroup
    }
}

extension MyGroupViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText (searchText: String) {
        filterMyGroup = myGroupArray.filter({ (filer: GroupsModel) -> Bool in
            return filer.groupName.lowercased().contains(searchText.lowercased())
        })
        
        myGroupTableView.reloadData()
    }
}
