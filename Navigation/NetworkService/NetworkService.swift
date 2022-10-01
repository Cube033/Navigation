//
//  NetworkService.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 30.09.2022.
//

import Foundation

enum AppConfiguration: String, CaseIterable{
    case link1 = "https://swapi.dev/api/people/8"
    case link2 = "https://swapi.dev/api/starships/3"
    case link3 = "https://swapi.dev/api/planets/5"
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        guard let url = URL(string: configuration.rawValue) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            self.handleAnswer(data: data, response: response, error: error)
        }
    task.resume()
    }
    
    static func handleAnswer(data:Data?, response:URLResponse?, error:Error?) {
        if let error = error {
            print("error: \(error.localizedDescription)")
        } else if let data = data {
            let dataDescription: String = String(bytes: data, encoding: .utf8) ?? ""
            print("data: \(dataDescription)")
            if let response = response as? HTTPURLResponse {
                print("allHeaderFields:")
                response.allHeaderFields.forEach({print("\($0.key) :  \($0.value)")})
                print("statusCode: \(response.statusCode)")
            }
        }
    }
}
