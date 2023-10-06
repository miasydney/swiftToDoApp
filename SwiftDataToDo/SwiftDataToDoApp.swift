//
//  SwiftDataToDoApp.swift
//  SwiftDataToDo
//
//  Created by Mia on 5/10/2023.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataToDoApp: App {
    
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(ItemsContainer.create(shouldCreateDefaulta: &isFirstTimeLaunch))
    }
}
