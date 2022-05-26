//
//  tiny_url_clientApp.swift
//  tiny_url_client
//
//  Created by Sai Nikhit Gulla on 26/05/22.
//

import SwiftUI

@main
struct tiny_url_clientApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
