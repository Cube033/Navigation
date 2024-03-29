//
//  Post.swift
//  Navigation
//
//  Created by Дмитрий on 15.08.2022.
//

import Foundation

public struct Post {
    public var id: Int
    public var title: String
    public var author: String = ""
    public var description: String
    public var image: String
    public var likes: Int = 0
    public var views: Int = 0
    
    public static func getPostArray() -> [Post] {
        var postArray = [Post]()
        postArray.append(Post(id: 0,
                              title: "Сидухи Astra J OPC",
                              description: "Ребят кому сидухи? От Atra J OPC. Перед и Зад. 150.000р",
                              image: "post1",
                              author: "Opel"))
        postArray.append(Post(id: 1,
                              title: "Чехол ручки КПП",
                              description: "Истрепался и облез чехол ручки КПП. Искал где заказать новый. Нашёл только статью о том как человек заказал в Ателье новый и заодно хорошую инструкцию по разбору.",
                              image: "post2",
                              author: "Citroen"))
        postArray.append(Post(id: 2,
                              title: "Новая машина в семье — Palisade",
                              description: "Появилась новая машина в нашей большой семье, Hyundai Palisade. Это авто зятя, предыдущий Мерседес GLK, про 2 поездки на котором всей семьёй с внучкой в горнолыжный отпуск из Тулы в Сочи Красную Поляну я писал в его БЖ.",
                              image: "post3",
                              author: "Hyundai"))
        postArray.append(Post(id: 3,
                              title: "Мойка фар Astra j gtc 1.4 turbo",
                              description: "Всем салам .Решил в свободный денёчек снять фары и помыть их изнутри, уж больно хотелось чтобы были в идеале.После полировки фар пол года назад, заметил, что как будто плохо отполировали, но нет, там была грязь внутри стекла, и вот в жаркий летний день +32 в тени и 1000 на солнце, снимал я фары.",
                              image: "post4",
                              author: "Opel"))
        return postArray
    }
    
    public init(id: Int, title: String, description: String, image: String, author: String){
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.author = author
    }
}
