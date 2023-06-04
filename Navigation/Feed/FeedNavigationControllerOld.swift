//
//  FeedNavigationController.swift
//  Navigation
//
//  Created by Дмитрий on 20.03.2022.
//

import UIKit
import StorageService

class FeedNavigationControllerOld: UIViewController {
    
    let feedCoordinator: FeedCoordinator

    let post = Post(id: 0, title: "Моя статья", description: "", image: "", author: "")
    lazy var checkGuessTextField: UITextField = {
        let checkGuessTextField = UITextField()
        checkGuessTextField.font = .systemFont(ofSize: 16)
        checkGuessTextField.tintColor = UIColor.tintColor
        checkGuessTextField.autocapitalizationType = .none
        checkGuessTextField.backgroundColor = Palette.textFieldBackgroundColor
        checkGuessTextField.layer.cornerRadius = 10
        checkGuessTextField.layer.borderColor = Palette.textFieldBorderColor
        checkGuessTextField.layer.borderWidth = 0.5
        checkGuessTextField.translatesAutoresizingMaskIntoConstraints = false
        checkGuessTextField.attributedPlaceholder = "enter_word".localized.attributedPlaceholder
        checkGuessTextField.leftView = .init(frame: .init(x: 0, y: 0, width: 5, height: checkGuessTextField.frame.height))
        checkGuessTextField.leftViewMode = .always
        return checkGuessTextField
    }()
    lazy var checkGuessButton = CustomButton(title: "check_word".localized, backgroundColor: nil, tapAction: {self.checkGuess()})
    lazy var button1 = getNewFeedButton()
    lazy var button2 = getNewFeedButton()
    let checkLabel: UILabel = {
        let label = UILabel()
        let nameLabelFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label.textColor = .black
        label.font = nameLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        return label
    }()
    private let nc = NotificationCenter.default
    
    private lazy var playerButton = CustomButton(title: "Player", backgroundColor: nil, tapAction: {self.feedCoordinator.handleAction(actionType: FeedActionType.alert)})
    
    private lazy var videoPlayerButton = CustomButton(title: "Video Player", backgroundColor: .red , tapAction: {self.feedCoordinator.handleAction(actionType: FeedActionType.videoPlayer)})
    
    private lazy var mapButton = CustomButton(title: "Open Map", backgroundColor: .green , tapAction: {self.feedCoordinator.handleAction(actionType: FeedActionType.mapViewController)})
    
    init(feedCoordinator: FeedCoordinator) {
        self.feedCoordinator = feedCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: NSNotification.Name("feedModelHandler"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nc.addObserver(self, selector: #selector(feedModelHandler(_:)), name: NSNotification.Name("feedModelHandler"), object: nil)
    }
    
    private func checkGuess() {
        let labelText = self.checkGuessTextField.text ?? ""
        if labelText == "" {
            setAlert()
        } else {
            let feedModel = FeedModel()
            feedModel.check(word: labelText)
        }
    }
    
    @objc func feedModelHandler(_ notification: Notification) {
        let wordIsCorrect = notification.object as! Bool
        if wordIsCorrect {
            checkLabel.backgroundColor = .green
        } else {
            checkLabel.backgroundColor = .red
        }
    }
    
    private func getNewFeedButton()->UIButton{
        return CustomButton(title: "go_to_post".localized,
                                  backgroundColor: .blue,
                                  tapAction: {
            self.feedCoordinator.handleAction(actionType: FeedActionType.post)
        })
    }
    
    private func setupView() {
        view.backgroundColor = Palette.viewControllerBackgroundColor
        layout()
    }
    
    private func layout() {
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(checkGuessTextField)
        self.view.addSubview(checkGuessButton)
        self.view.addSubview(checkLabel)
        self.view.addSubview(playerButton)
        self.view.addSubview(videoPlayerButton)
        self.view.addSubview(mapButton)
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button1.heightAnchor.constraint(equalToConstant: 30),
            button1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            button2.leadingAnchor.constraint(equalTo: button1.leadingAnchor),
            button2.trailingAnchor.constraint(equalTo: button1.trailingAnchor),
            button2.heightAnchor.constraint(equalToConstant: 30),
            
            checkGuessTextField.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20),
            checkGuessTextField.leadingAnchor.constraint(equalTo: button2.leadingAnchor),
            checkGuessTextField.trailingAnchor.constraint(equalTo: button2.trailingAnchor),
            checkGuessTextField.heightAnchor.constraint(equalToConstant: 20),
            
            checkGuessButton.topAnchor.constraint(equalTo: checkGuessTextField.bottomAnchor, constant: 16),
            checkGuessButton.leadingAnchor.constraint(equalTo: checkGuessTextField.leadingAnchor),
            checkGuessButton.trailingAnchor.constraint(equalTo: checkGuessTextField.trailingAnchor),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 30),
            
            checkLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            checkLabel.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor),
            checkLabel.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor),
            checkLabel.heightAnchor.constraint(equalToConstant: 30),
            
            playerButton.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 16),
            playerButton.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor),
            playerButton.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor),
            playerButton.heightAnchor.constraint(equalToConstant: 30),
            
            videoPlayerButton.topAnchor.constraint(equalTo: playerButton.bottomAnchor, constant: 16),
            videoPlayerButton.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor),
            videoPlayerButton.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor),
            videoPlayerButton.heightAnchor.constraint(equalToConstant: 30),
            
            mapButton.topAnchor.constraint(equalTo: videoPlayerButton.bottomAnchor, constant: 16),
            mapButton.leadingAnchor.constraint(equalTo: videoPlayerButton.leadingAnchor),
            mapButton.trailingAnchor.constraint(equalTo: videoPlayerButton.trailingAnchor),
            mapButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setAlert() {
        let alert = UIAlertController(title: "error".localized, message: "enter_verification_word".localized, preferredStyle: .alert)
        let actionDismiss = UIAlertAction(title: "Ok", style: .default) { (_) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(actionDismiss)
        
        self.present(alert, animated: true, completion: nil)
    }
}


