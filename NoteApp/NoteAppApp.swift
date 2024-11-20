//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by i0240 on 20.11.2024.
//

import SwiftUI

@main
struct NoteAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
