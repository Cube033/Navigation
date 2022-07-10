//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 09.05.2022.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
    
    let colorSet = UIColor(red: 0.28, green: 0.52, blue: 0.80, alpha: 1.00)
    let scrollView = UIScrollView()
    let contentView = UIView()
    let logoImageView = UIImageView()
    lazy var logInTextField = UITextField()
    lazy var passwordTextField = UITextField()
    var logInButton = UIButton()
    var logInStackView = UIStackView()
    private let nc = NotificationCenter.default
   
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
    
    private func setView(){
        setElements()
        addElements()
        setConstraints()
    }
    
    private func setElements(){
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        view.clipsToBounds = true
        
        setLogoImageView()
        setLogInTextField()
        setPasswordTextField()
        setLogInButton()
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
            logInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setLogoImageView() {
        let logoImage = UIImage(named: "vkLogo")
        logoImageView.image = logoImage
        logoImageView.clipsToBounds = true
        logoImageView.layer.masksToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLogInTextField() {
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
        logInTextField.placeholder = "Email or phone"
        logInTextField.leftView = .init(frame: .init(x: 0, y: 0, width: 5, height: logInTextField.frame.height))
        logInTextField.leftViewMode = .always
        logInTextField.delegate = self
    }
    
    private func setPasswordTextField() {
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
    }
    
    private func setLogInButton() {
        logInButton.layer.cornerRadius = 10.0
        logInButton.setTitle("Log in", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        logInButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel")!)
    }
    
    @objc private func buttonAction(){
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


