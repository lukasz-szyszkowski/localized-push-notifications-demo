//
//  NotificationService.swift
//  APNS Mutable Content Extension
//
//  Created by Łukasz Szyszkowski on 09/02/2021.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        let langCode = LanguageController.shared.getLanguage().code
        
        if
            let mutableContent = (request.content.mutableCopy() as? UNMutableNotificationContent),
            let extractedMessage = LanguageController.shared.extractLocalizedMessage(from: request.content.userInfo, for: langCode),
            let title = extractedMessage[LanguageController.Constansts.Push.titleKey],
            let body = extractedMessage[LanguageController.Constansts.Push.bodyKey]
        {
            
            mutableContent.title = title
            mutableContent.body = body
            
            contentHandler(mutableContent)
        } else {
            contentHandler(request.content)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {}
}
