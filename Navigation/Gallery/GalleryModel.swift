//
//  GalleryModel.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 27.09.2022.
//

import Foundation
import UIKit

class GalleryModel {
    
    static var photosArray: [UIImage] {
        get {
            var array = [UIImage]()
            for element in 0...19 {
                array.append(UIImage(named: "gallery\(element)")!)
            }
            return array
        }
    }
    
    static func getPartOfArray(numberOfElements: Int) -> [UIImage]{
        var maxElement = numberOfElements
        if maxElement > 19 {
            maxElement = 19
        }
        var array = [UIImage]()
        for element in 0...maxElement {
            array.append(UIImage(named: "gallery\(element)")!)
        }
        return array
    }
}
