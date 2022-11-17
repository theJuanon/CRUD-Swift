//
//  CRUD_SwiftApp.swift
//  CRUD-Swift
//
//  Created by CCDM01 on 17/11/22.
//

import SwiftUI

@main
struct CRUD_SwiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
