//
//  SetingsViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 14/08/21.
//
// Этот class отвечает за ViewController Настроек

import UIKit

class SetingsViewController: UIViewController {
    
    @IBOutlet var setingsTableView: UITableView!
    
    // создаем массив настроек
    let setingsArray = ["Почта", "Адресса", "Контакты", "Общий вид"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setingsTableView.delegate = self // подписываем таблицу под дилигат
        setingsTableView.dataSource = self // таблица будет управляться нашим контроллером
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setingsSegue" {
            let distanationVC = segue.destination
            guard let indexSelectionCell = setingsTableView.indexPathForSelectedRow?.row else { return }
            distanationVC.title = setingsArray[indexSelectionCell]
        }
    }
}

extension SetingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setingsArray.count // скоолько секций в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setingsCell = tableView.dequeueReusableCell(withIdentifier: SetingsTableViewCelTableViewCell.inditiferSetingsCel) as! SetingsTableViewCelTableViewCell
        setingsCell.configure(avatarName: "setingsMail", titlelCell: setingsArray[indexPath.row])
        return setingsCell
    }
    
    
}
