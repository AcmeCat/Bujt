//
//  BujtApp.swift
//  Bujt
//
//  Created by Rory Allen on 18/2/2024.
//

import SwiftUI

@main
struct BujtApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(context: dataController.container.viewContext)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
