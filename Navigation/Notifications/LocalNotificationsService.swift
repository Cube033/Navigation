//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 21.02.2023.
//

import UserNotifications

class LocalNotificationsService {
    
    func registeForLatestUpdatesIfPossible() {
        let notificationCenter = UNUserNotificationCenter.current()
       notificationCenter.requestAuthorization(options: [.sound, .badge, .provisional], completionHandler: { success, error in
            if success {
                self.setNotifications()
            }
        } )
    }
    
    private func setNotifications() {
        
        let setted = UserDefaults.standard.bool(forKey: "NotificationsSetted")
        if !setted {
            let notificationCenter = UNUserNotificationCenter.current()
            
            let content = UNMutableNotificationContent()
            content.title = "Посмотрите последние обновления"
            content.body = "Не упустите важную информацию"
            content.badge = 1
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 19
            dateComponents.minute = 00
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: trigger)

            notificationCenter.add(request)
            UserDefaults.standard.set(true, forKey: "NotificationsSetted")
        }
    }
}
