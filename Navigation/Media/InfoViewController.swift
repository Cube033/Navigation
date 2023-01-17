//
//  InfoViewController.swift
//  Navigation
//
//  Created by Дмитрий on 21.03.2022.
//

import UIKit
import AVFoundation

class InfoViewController: UIViewController {
    
    enum SongAction{
        case startPlaying
        case nextSong
        case previousSong
    }
    
    var navPlayer = AVAudioPlayer()
    var songArray:[String] = ["Кино - Невеселая песня", "Мультфильмы - За нами следят", "futurama", "Queen", "Rammstein - Feuer Frei"]
    var currentSongNumber: Int = 0
    var currentSongName: String {
        get{
        songArray[currentSongNumber]
    }}
    var songNameLabel = CustomLabel(fontSize: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navPlayer.stop()
    }
    
    private lazy var playPauseButton: UIButton = CustomButton(title: "Play / Pause", backgroundColor: nil, tapAction: {self.playPase()})
    
    private lazy var stopMusicButton: UIButton = CustomButton(title: "Stop", backgroundColor: nil, tapAction: {self.stopMusic()})
    
    private lazy var previousSongButton: UIButton = CustomButton(title: "<<", backgroundColor: nil, tapAction: {self.setupPlayer(action: .previousSong)})
    
    private lazy var nextSongButton: UIButton = CustomButton(title: ">>", backgroundColor: nil, tapAction: {self.setupPlayer(action: .nextSong)})
    
    
    
    private lazy var button: UIButton = CustomButton(title: "available_actions".localize, backgroundColor: nil, tapAction: {self.setAlert()})
    
    private func setupView(){
        view.backgroundColor = .systemPink
        setupButton()
        
        setupPlayer(action: .startPlaying)
        layout()
    }
    
    private func setupPlayer(action: SongAction) {
        let isPlayingNow = navPlayer.isPlaying
        setCurrentSong(action: action)
        songNameLabel.text = currentSongName
        do {
            navPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currentSongName, ofType: "mp3")!))
            navPlayer.prepareToPlay()
            if isPlayingNow {
                navPlayer.play()
            }
        }
        catch {
            print(error)
        }
        
    }
    
    private func setCurrentSong(action: SongAction) {
        switch action {
        case .startPlaying:
            currentSongNumber = 0
        case .nextSong:
            if currentSongNumber == 4 {
                currentSongNumber = 0
            } else {
                currentSongNumber += 1
            }
        case .previousSong:
            if currentSongNumber == 0 {
                currentSongNumber = 4
            } else {
                currentSongNumber -= 1
            }
        }
    }
    
    private func setupButton() {
        self.view.addSubview(self.button)
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func playPase() {
        if navPlayer.isPlaying {
            navPlayer.stop()
        }
        else {
            navPlayer.play()
        }
    }
    
    private func stopMusic(){
        if navPlayer.isPlaying {
            navPlayer.stop()
        }
        navPlayer.currentTime = 0
    }
    
    private func setAlert() {
        let alert = UIAlertController(title: "actions".localize, message: "select_an_action".localize, preferredStyle: .alert)
        let actionPrint = UIAlertAction(title: "output_text_to_console".localize, style: .default) { (_) -> Void in
            //print("Вывести текст")
        }
        let actionDismiss = UIAlertAction(title: "close_window".localize, style: .default) { (_) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(actionPrint)
        alert.addAction(actionDismiss)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func layout(){
        view.addSubview(songNameLabel)
        view.addSubview(playPauseButton)
        view.addSubview(stopMusicButton)
        view.addSubview(previousSongButton)
        view.addSubview(nextSongButton)
        
        
        NSLayoutConstraint.activate([
            songNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            songNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            songNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            songNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            playPauseButton.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 16),
            playPauseButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            playPauseButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            playPauseButton.heightAnchor.constraint(equalToConstant: 30),
            
            stopMusicButton.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 16),
            stopMusicButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stopMusicButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stopMusicButton.heightAnchor.constraint(equalToConstant: 30),
            
            previousSongButton.topAnchor.constraint(equalTo: stopMusicButton.bottomAnchor, constant: 16),
            previousSongButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            previousSongButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -8),
            previousSongButton.heightAnchor.constraint(equalToConstant: 30),
            
            nextSongButton.topAnchor.constraint(equalTo: stopMusicButton.bottomAnchor, constant: 16),
            nextSongButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 8),
            nextSongButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nextSongButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
