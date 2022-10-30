//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 09.05.2022.
//

import Foundation
import UIKit

fileprivate enum LoginState {
    case login
    case signUp
    case disable
}

class LogInViewController: UIViewController {
    
    fileprivate var loginButtonState: LoginState = .disable
    var loginDelegate: LoginViewControllerDelegate?
    let colorSet = UIColor(red: 0.28, green: 0.52, blue: 0.80, alpha: 1.00)
    let scrollView = UIScrollView()
    let contentView = UIView()
    let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        let logoImage = UIImage(named: "vkLogo")
        logoImageView.image = logoImage
        logoImageView.clipsToBounds = true
        logoImageView.layer.masksToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    lazy var logInTextField: UITextField = {
        let logInTextField = UITextField()
        logInTextField.font = .systemFont(ofSize: 16)
        logInTextField.tintColor = UIColor.tintColor
        logInTextField.autocapitalizationType = .none
        logInTextField.backgroundColor = .systemGray6
        logInTextField.layer.cornerRadius = 10
        logInTextField.layer.borderColor = UIColor.lightGray.cgColor
        logInTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        logInTextField.layer.borderColor = UIColor.lightGray.cgColor
        logInTextField.layer.borderWidth = 0.5
        logInTextField.translatesAutoresizingMaskIntoConstraints = false
        logInTextField.placeholder = "Email"
        logInTextField.leftView = .init(frame: .init(x: 0, y: 0, width: 5, height: logInTextField.frame.height))
        logInTextField.leftViewMode = .always
        logInTextField.delegate = self
        logInTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        return logInTextField
    }()
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.font = .systemFont(ofSize: 15)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftView = .init(frame: .init(x: 0, y: 0, width: 5, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        return passwordTextField
    }()
    private let nc = NotificationCenter.default
    let mainCoordinator: MainCoordinator
    
    lazy var logInButton = CustomButton(title: "Log in",
                                        backgroundColor: nil,
                                        tapAction: {self.logIn()})
    lazy var bruteForceButton = CustomButton(title: "Подобрать пароль",
                                             backgroundColor: nil,
                                             tapAction: {self.bruteForce()})
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private let queue = DispatchQueue(label: "com.Navigation.brute-force", qos:.default)
    
    private var hackerModeOn = false
    
    var loginReminderTimer: Timer?
    
    init (mainCoordinator:MainCoordinator) {
        self.mainCoordinator = mainCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        loginReminderTimer = nil
    }
    
    @objc private func kbdShow(notification: NSNotification){
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide(){
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func bruteForce(){
        self.activityIndicator.startAnimating()
        let bruteForce = BruteForce()
        let randomPassword = bruteForce.getRandomPassword(lenght: 3)
#if DEBUG
        print(randomPassword)
#endif
        queue.async {
            let stolenPassword = bruteForce.bruteForce(passwordToUnlock: randomPassword)
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.succesHacking(stolenPassword: stolenPassword)
            }
        }
    }
    
    private func succesHacking(stolenPassword: String){
        self.passwordTextField.text = stolenPassword
        self.passwordTextField.isSecureTextEntry = false
        self.hackerModeOn = true
    }
    
    private func logIn(){
        let userSevice = CurrentUserService()
        
        if hackerModeOn {
            startApplication(user: userSevice.getUserByLogin(login: "cube033")!)
            return
        }
#if DEBUG
        startApplication(user: userSevice.getUserByLogin(login: "cube033")!)
#else
        if let loginDelegateExist = self.loginDelegate {
            loginDelegateExist.checkCredentials(login: self.logInTextField.text!, password: self.passwordTextField.text!, completion: {[weak self] (loginResult: Result<User, LoginError>) in
                guard let strongSelf = self else { return }
                switch loginResult {
                case .success(let user):
                    strongSelf.startApplication(user: user)
                case .failure(let loginError):
                    switch loginError {
                    case .invalidEmail:
                        strongSelf.setAlert(errorMessage: "Не верно указан Email")
                    case .userNotFound:
                        strongSelf.loginButtonState = .signUp
                        strongSelf.setAlert(errorMessage: "Пользователь не найден")
                    case .wrongPassword:
                        strongSelf.setAlert(errorMessage: "Не верно указан пароль")
                    default:
                        strongSelf.setAlert(errorMessage: "Ошибка авторизации")
                    }
                }
            })
        }
#endif
    }
    
    private func startApplication(user: User) {
        UserInfo.shared.setUser(user: user)
        mainCoordinator.startApplication()
    }
    
    private func setView(){
        setElements()
        addElements()
        setConstraints()
        setLoginButtonState()
        loginReminderTimer = Timer.scheduledTimer(withTimeInterval: 180, repeats: true, block: {
            timer in
            self.setReminderAlert(timer: timer)
        })
    }
    
    private func setLoginButtonState(){
        if logInTextField.text ?? "" != "" && passwordTextField.text ?? "" != "" {
            loginButtonState = .login
        } else {
            loginButtonState = .disable
        }
        switch loginButtonState {
        case .disable:
            logInButton.isEnabled = false
            logInButton.configuration?.title = "Введите email и пароль"
        case .login:
            logInButton.isEnabled = true
            logInButton.configuration?.title = "Вход"
        case .signUp:
            logInButton.isEnabled = true
            logInButton.configuration?.title = "Зарегистрироваться"
        }
        
    }
    
    private func setElements(){
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        view.clipsToBounds = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .blue
    }
    
    private func addElements(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(logInTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)
    }
    
    private func setConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            logInTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            logInTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: logInTextField.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Ошибка", message: errorMessage, preferredStyle: .alert)
        let actionDismiss = UIAlertAction(title: "Закрыть", style: .default) { (_) -> Void in
            
        }
        if loginButtonState == .signUp {
            if let loginDelegateExist = self.loginDelegate {
                let actionSignUp =  UIAlertAction(title: "Зарегистрироваться", style: .default) { (_) -> Void in
                    loginDelegateExist.signUp(login: self.logInTextField.text!, password: self.passwordTextField.text!, completion: {[weak self] (user:User?) in
                        guard let strongSelf = self else { return }
                        if let userExist = user {
                            strongSelf.startApplication(user: userExist)
                        } else {
                            strongSelf.setLoginButtonState()
                            strongSelf.setAlert(errorMessage: "Не удалось создать пользователя. Убедитесь, что длина пароля не менее 6 символов")
                        }
                    })
                }
                alert.addAction(actionSignUp)
            }
        }
        alert.addAction(actionDismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        setLoginButtonState()
    }
    
    private func setReminderAlert(timer: Timer) {
        let alert = UIAlertController(title: "Забыли пароль?", message: "Не беда! Давайте взломаем приложение", preferredStyle: .alert)
        let startHacking = UIAlertAction(title: "Хорошо, ломаем", style: .default) { (_) -> Void in
            self.startHacking()
            timer.invalidate()
        }
        let actionDismiss = UIAlertAction(title: "Ещё чуть-чуть и сам(а) вспомню", style: .default) { (_) -> Void in
            
        }
        alert.addAction(startHacking)
        alert.addAction(actionDismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func startHacking(){
        contentView.addSubview(bruteForceButton)
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            bruteForceButton.topAnchor.constraint(equalTo: self.logInButton.bottomAnchor, constant: 16),
            bruteForceButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            bruteForceButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            bruteForceButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.passwordTextField.trailingAnchor, constant: -16),
        ])
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
