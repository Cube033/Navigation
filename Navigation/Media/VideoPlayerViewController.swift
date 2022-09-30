//
//  VideoPlayerViewController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 29.09.2022.
//

import UIKit

import UIKit
import AVFoundation
import AVKit

class VideoPlayerViewController: UIViewController {
    
    private lazy var streamURL = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")!
    //private lazy var streamURL = URL(string: "https://www.youtube.com/watch?v=Oj1vBI_TI7Q")!
    
    private lazy var localURL: URL = {
        let path = Bundle.main.path(forResource: "test", ofType: "mp4")!
        return URL(fileURLWithPath: path)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        playButtonPressed()
    }
    
    func playButtonPressed() {
        // Создаём AVPlayer со ссылкой на видео.
        let player = AVPlayer(url: streamURL)
        
        // Создаём AVPlayerViewController и передаём ссылку на плеер.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Показываем контроллер модально и запускаем плеер.
        present(controller, animated: true) {
            player.play()
        }
    }
    
    func alternativePlay() {
        let streamingURL = NSURL(string: "https://www.youtube.com/watch?v=Oj1vBI_TI7Q")
        let playerController = AVPlayerViewController()
        playerController.player = AVPlayer(url: streamingURL! as URL)
        present(playerController, animated: true) {
        playerController.player?.play()
        }
    }
}
