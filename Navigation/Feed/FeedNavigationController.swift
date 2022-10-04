//
//  FeedNavigationController.swift
//  Navigation
//
//  Created by Дмитрий on 20.03.2022.
//

import UIKit
import StorageService

class FeedNavigationController: UIViewController {
    
    let feedCoordinator: FeedCoordinator

    let post = Post(title: "Моя статья", description: "", image: "")
    lazy var checkGuessTextField: UITextField = {
        let checkGuessTextField = UITextField()
        checkGuessTextField.font = .systemFont(ofSize: 16)
        checkGuessTextField.tintColor = UIColor.tintColor
        checkGuessTextField.autocapitalizationType = .none
        checkGuessTextField.backgroundColor = .systemGray6
        checkGuessTextField.layer.cornerRadius = 10
        checkGuessTextField.layer.borderColor = UIColor.lightGray.cgColor
        checkGuessTextField.layer.borderColor = UIColor.lightGray.cgColor
        checkGuessTextField.layer.borderWidth = 0.5
        checkGuessTextField.translatesAutoresizingMaskIntoConstraints = false
        checkGuessTextField.placeholder = "Введите слово"
        checkGuessTextField.leftView = .init(frame: .init(x: 0, y: 0, width: 5, height: checkGuessTextField.frame.height))
        checkGuessTextField.leftViewMode = .always
        return checkGuessTextField
    }()
    lazy var checkGuessButton = CustomButton(title: "Проверить слово", backgroundColor: nil, tapAction: {self.checkGuess()})
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
    
    private lazy var networkJSONSerializationButton = CustomButton(title: "JSON Serialization", backgroundColor: .darkGray , tapAction: {self.networkAction(appConfig: .link4)})
    
    private lazy var networkJSONDecoderButton = CustomButton(title: "JSON Decoder", backgroundColor: .darkGray , tapAction: {self.networkAction(appConfig: .link5)})
    
    private lazy var networkLabel = CustomLabel(fontSize: 14)
    
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
    
    private func networkAction(appConfig: AppConfiguration) {
        switch appConfig {
        case .link4:
            NetworkService.request(for: appConfig, completion: {(textAnswer)->Void in
                self.networkLabel.text = textAnswer ?? "no result in answer"
                                   })
        case .link5:
            NetworkService.request(for: appConfig, completion: {(textAnswer)->Void in
                self.networkLabel.text = textAnswer ?? "no result in answer"
                })
        default:
            let appDelegat = UIApplication.shared.delegate as? AppDelegate
            if let appDelegatExist = appDelegat {
                NetworkService.request(for: appDelegatExist.appConfiguration, completion: {(textAnswer) ->Void in print(textAnswer ?? "")})
            }
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
        return CustomButton(title: "Перейти на пост",
                                  backgroundColor: .blue,
                                  tapAction: {
            self.feedCoordinator.handleAction(actionType: FeedActionType.post)
        })
    }
    
    private func setupView() {
        view.backgroundColor = .white
        layout()
        networkLabel.text = "Network service"
    }
    
    private func layout() {
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(checkGuessTextField)
        self.view.addSubview(checkGuessButton)
        self.view.addSubview(checkLabel)
        self.view.addSubview(playerButton)
        self.view.addSubview(videoPlayerButton)
        self.view.addSubview(networkJSONSerializationButton)
        self.view.addSubview(networkJSONDecoderButton)
        self.view.addSubview(networkLabel)
        
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
            
            networkJSONSerializationButton.topAnchor.constraint(equalTo: videoPlayerButton.bottomAnchor, constant: 16),
            networkJSONSerializationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            networkJSONSerializationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -5),
            networkJSONSerializationButton.heightAnchor.constraint(equalToConstant: 30),
            
            networkJSONDecoderButton.topAnchor.constraint(equalTo: videoPlayerButton.bottomAnchor, constant: 16),
            networkJSONDecoderButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 5),
            networkJSONDecoderButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            networkJSONDecoderButton.heightAnchor.constraint(equalToConstant: 30),
            
            networkLabel.topAnchor.constraint(equalTo: networkJSONSerializationButton.bottomAnchor, constant: 16),
            networkLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            networkLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            networkLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Введите проверочное слово", preferredStyle: .alert)
        let actionDismiss = UIAlertAction(title: "Ok", style: .default) { (_) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(actionDismiss)
        
        self.present(alert, animated: true, completion: nil)
    }
}


