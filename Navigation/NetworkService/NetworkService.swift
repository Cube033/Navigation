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
    case link4 = "https://jsonplaceholder.typicode.com/todos/4"
    case link5 = "https://swapi.dev/api/planets/1"
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration, completion: @escaping (String?)->Void) {
        guard let url = URL(string: configuration.rawValue) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let answerText = self.handleAnswer(data: data, response: response, error: error, config: configuration)
            DispatchQueue.main.async {
                completion(answerText)
            }
        }
        task.resume()
    }
    
    static func handleAnswer(data:Data?, response:URLResponse?, error:Error?, config: AppConfiguration) -> String? {
        if let error = error {
            return error.localizedDescription
        } else if let data = data {
            switch config {
            case .link4:
                return handleJSONSerialization(data: data, response:response)
            case .link5:
                return handleJSONDecoder(data: data, response:response)
            default:
                
                let dataDescription: String = String(bytes: data, encoding: .utf8) ?? ""
                print("data: \(dataDescription)")
                if let response = response as? HTTPURLResponse {
                    print("allHeaderFields:")
                    response.allHeaderFields.forEach({print("\($0.key) :  \($0.value)")})
                    print("statusCode: \(response.statusCode)")
                }
            }
            return nil
        }
        return nil
    }
    
    static func handleJSONSerialization(data:Data, response:URLResponse?) -> String?{
        var resultText: String = "no result"
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            if let dictionary = jsonObject as? [String: Any] {
                let userId: Int = dictionary["userId"] as? Int ?? 0
                let id: Int = dictionary["id"] as? Int ?? 0
                let title: String = dictionary["title"] as? String ?? ""
                let completed: Bool = dictionary["completed"] as? Bool ?? false
                let newJsonModel = JSONSerializationModel(userId: userId, id: id, title: title, completed: completed)
                #if DEBUG
                print(newJsonModel)
                #endif
                resultText = title
            }
        } catch let error {
            return error.localizedDescription
        }
        return resultText
    }
    
    static func handleJSONDecoder(data:Data, response:URLResponse?) -> String?{
        var resultText: String = "no result"
        do {
            let newJsonModel = try JSONDecoder().decode(JSONDecodingModel.self, from: data)
#if DEBUG
            print(newJsonModel)
#endif
            resultText = "Период обращения планеты: " + String(newJsonModel.orbital_period)
        } catch let error {
            return error.localizedDescription
        }
        return resultText
    }
}
