//
//  MyGroupViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 14/08/21.
//

import UIKit

class MyGroupViewController: UIViewController {

    @IBOutlet private var myGroupTableView: UITableView!
    
    let myGroupData: GroupData = GroupData()
    var myGroupArray: [GroupsModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myGroupArray = myGroupData.myGroup
        
        myGroupTableView.delegate = self
        myGroupTableView.dataSource = self
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToViewSelectionGroupSegue" {
            let distanationVC = segue.destination
            guard let indexAllGroupCell = myGroupTableView.indexPathForSelectedRow?.row else { return }
            distanationVC.title = myGroupArray[indexAllGroupCell].groupName
        }
    }
    
    @IBAction func addGroupsInMyGroups (_ segue: UIStoryboardSegue) {
        guard let sourseController = segue.source as? AllGroupViewController,
              let indexSelectionCell = sourseController.allGroupTableView.indexPathForSelectedRow
            else { return }
        
        //получаем название группы из массива всех групп
        let groups = sourseController.allGroupArray[indexSelectionCell.row]
                
        // проверяем если группа не содержиться то добавляем
        // В этом замыкании вы сравнивате имя одной группы с именем другой группы. в $0 поочереди приходят группы из вашего массива в контроллере Мои группы у которых затем отбираются имена , а первое значение groups.groupName мы получили из контроллера со всеми группами.
        if !myGroupArray.contains(where: { groups.groupName == $0.groupName }) {
            myGroupArray.append(groups)
        }
                
        // После того как добавили то надо перезагрузить таблицу
        myGroupTableView.reloadData()
    }
}

extension MyGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroupArray.count // скоолько секций в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myGroupCell = tableView.dequeueReusableCell(withIdentifier: MyGroupTableViewCell.indetifarMyGroup) as! MyGroupTableViewCell
        
        myGroupCell.configureMyGroup(groups: myGroupArray[indexPath.row])
        return myGroupCell
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // если была нажата кнопка удалить
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func deleteAction (at indexPath: IndexPath) -> UIContextualAction {
        let actionDel = UIContextualAction(style: .destructive, title: "Удаление") { actionDel, view, complaction in
            //удаляем группу из масива
            self.myGroupArray.remove(at: indexPath.row)
            // удаляем строку из таблицы
            self.myGroupTableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        actionDel.backgroundColor = .red
        actionDel.image = UIImage(systemName: "trash.fill")
        return actionDel
    }
}

