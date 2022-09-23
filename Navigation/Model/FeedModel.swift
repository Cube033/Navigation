//
//  FeedModel.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 22.09.2022.
//

import Foundation

class FeedModel {
    
    let secretWord = "secretWord"
    
    func check(word: String){
        let wordIsCorrect = word == secretWord
        NotificationCenter.default.post(name:NSNotification.Name("feedModelHandler"), object: wordIsCorrect)
    }
}
