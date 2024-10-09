import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications

class TradingSimonDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let ndjsakdnksa = notification.request.content.userInfo
        if let idOfPush = ndjsakdnksa["push_id"] as? String {
            savePushId(idOfPush)
        }
        completionHandler([.badge, .sound, .alert])
    }
    
    private func savePushId(_ idOfPush: String) {
        UserDefaults.standard.set(idOfPush, forKey: "push_id")
    }
    
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound],
        completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let ndjsakdnksa = response.notification.request.content.userInfo
        if let idOfPush = ndjsakdnksa["push_id"] as? String {
            savePushId(idOfPush)
        }
        completionHandler()
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            UserDefaults.standard.set(token, forKey: "fcm_token")
            NotificationCenter.default.post(name: Notification.Name("fcm_token"), object: nil)
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

