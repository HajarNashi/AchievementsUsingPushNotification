//
//  iCloudNotificationApp.swift
//  iCloudNotification
//
//  Created by Hajar Nashi on 18/12/2022.
//

import SwiftUI

@main
struct iCloudNotificationApp: App {
    var body: some Scene {
        WindowGroup {
          // CloudKitNotificationBoot()
            CloudKitCrudBoot()
           // CloudKitUserBoot()
        }
    }
}
