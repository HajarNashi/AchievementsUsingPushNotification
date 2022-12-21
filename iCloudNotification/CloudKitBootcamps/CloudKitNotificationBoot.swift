//
//  CloudKitNotificationBoot.swift
//  iCloudNotification
//
//  Created by Hajar Nashi on 20/12/2022.
//

import SwiftUI
import CloudKit

class CloudKitNotificationBootViewModel: ObservableObject {
    
    let container = CKContainer(identifier: "iCloud.com.Notification.Hajar.Nashi")
    
    func requestNotificationPermissions() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error)
            } else if success {
                print("Notification permissions success!")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Notification permissions failure.")
            }
        }
    }
    
    func subscribeToNotifications() {
        
        let predicate = NSPredicate(value: true)
        
        let subscription = CKQuerySubscription(recordType: "Fruits", predicate: predicate, subscriptionID: "fruit_added_to_database", options: .firesOnRecordCreation)
        
        let notifaction = CKSubscription.NotificationInfo()
        notifaction.title = "There's a new fruit!"
        notifaction.alertBody = "Open the app to check your fruits."
        notifaction.soundName = "default"
        
        subscription.notificationInfo = notifaction
        
        container.publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully subscribed to notifactions!")
            }
        }
        
    }
    
    func unsubscribeToNotifications() {
        container.publicCloudDatabase.delete(withSubscriptionID: "fruit_added_to_database") {
            returnedID, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully unsubscribed")
            }
        }
    }
}

struct CloudKitNotificationBoot: View {
    
    @StateObject private var vm = CloudKitNotificationBootViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            
            Button("Request notification permission") {
                vm.requestNotificationPermissions()
            }
            
            Button("Subscribe to notifications") {
                vm.subscribeToNotifications()
            }
            
            Button("Unsubscribe to notifications") {
                vm.unsubscribeToNotifications()
            }

        }
    }
}

struct CloudKitNotificationBoot_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitNotificationBoot()
    }
}
