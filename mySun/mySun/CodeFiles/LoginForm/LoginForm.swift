//
//  LoginForm.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 07/08/21.
//

import UIKit
import Foundation

final class LoginFormVievController: UIViewController {
    
    private var splashImageView: UIImageView = {
        let splashImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        splashImageView.image = UIImage(named: "VK.com-logo.svg")
        return splashImageView
    }()
    
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var popUPView: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var returnButttton: UIButton!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var logoImageVIEW: UIImageView!
    @IBOutlet private var scrolViewOnForm: UIScrollView!
    var efectView: UIVisualEffect!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        // отключаем эфект размытия в начале
        efectView = visualEffectView.effect
        visualEffectView.effect = nil
        popUPView.layer.cornerRadius = 30 // скругление краёв у UIView
        // Добавляем жесть нажатия
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // испльзуем его на UIScrollView
        scrolViewOnForm?.addGestureRecognizer(tap)
        view.addSubview(splashImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        splashImageView.center = view.center
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animatedVkLogo()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Клавиатура появляется
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShows), name: UIResponder.keyboardWillShowNotification, object: nil)
        // клавиатура исчезает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Отписка от всего
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Метод оброботки пароля и логина
    // Данный метод отвечает за выполнение той или иноого segue согласно segueID
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "dataIsCorrect" {
            let login = loginTextField.text
            let pass = passwordTextField.text
            if login == "V" && pass == "v" { return true }
            else {
                animationInUIViewPopUp()
                return false
            }
        } else {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "demo" {
            let destinationControoller = segue.destination as! UITabBarController
            destinationControoller.viewControllers?.forEach { $0.view.backgroundColor = .red }
        }
    }
    
    @IBAction func logaut(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction private func loginButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func demoButton(_ sender: UIButton) {
        
    }
    
    @IBAction func returnLoginForm(_ sender: UIButton) { animationOutUIViewPopUp() }
    
    //ДЛЯ СКРОЛИНГА
    // Когда клавиатура появляется
    @objc func keyboardWasShows (notification: Notification) {
        // получаем размер кавиатуры
        let info = notification.userInfo! as NSDictionary // обычный ловарь из Notification
        let sizeKeyboard = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        // отступы внутри UIScrollView равны нулю однако когда клавиатура пояаляется то отступ снизу становиться равным bottom: sizeKeyboard.height
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: sizeKeyboard.height, right: 0.0)
        
        // добавляем отступ внизу UIScrollView который равен размеру клвиатуры
        self.scrolViewOnForm?.contentInset = contentInsets
        scrolViewOnForm?.scrollIndicatorInsets = contentInsets
    }
    
    // когда клавиатура исчезла
    @objc func keyboardWillBeHidden (notification: Notification) {
        let contentInsets = UIEdgeInsets.zero // устанавливаем отступ внизу тUIScrollView раавным нулю
        scrolViewOnForm?.contentInset = contentInsets
        scrolViewOnForm?.scrollIndicatorInsets = contentInsets
    }
    
    // для того чтобы скрыть клавиату по тапу в любом месте экрана
    @objc func hideKeyboard () {
        // для того что бы клавиатура исчезла небходимо закончить редактирование внутри всех UITextField
        // но так как у нас есть UIScrollView то мы воспользуемся тем что все UITextField лежат внутри него
        self.scrolViewOnForm?.endEditing(true)
    }
    
    // метод вызывающий анимацию
    private func animationInUIViewPopUp() {
        self.view.addSubview(popUPView) // добаавили всплывающие окно на основное окно
        popUPView.center = self.view.center // сцентровали всплывающее окно
        // трансформирование окна из маленького в боольшое
        popUPView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3) // создача маленького квадрата
        popUPView.alpha = 0 // не видимый квадрат в начале анимации
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.efectView // возвращаем квадрат в исходное плоложение
            self.popUPView.alpha = 1 // меняем прозрачность всплывающего окна
            self.popUPView.transform = CGAffineTransform.identity // трансформирование в оригенальный размер
        }
    }
    
    //метод убирающий анимацию
    private func animationOutUIViewPopUp() {
        UIView.animate(withDuration: 0.4) {
            self.popUPView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUPView.alpha = 0
            self.visualEffectView.effect = nil
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        } completion: { (sucses: Bool) in
            self.popUPView.removeFromSuperview() // убираем с основного экрана
        }
    }
    
    private func animatedVkLogo() {
        UIView.animate(withDuration: 0.4, animations: {
            let size = self.view.frame.size.width * 7
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.splashImageView.frame = CGRect(
                                                x: -(diffX) / 2,
                                                y: diffY / 2,
                                                width: size,
                                                height: size
                                            )
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.splashImageView.alpha = 0
            
        })
        
    }
}
