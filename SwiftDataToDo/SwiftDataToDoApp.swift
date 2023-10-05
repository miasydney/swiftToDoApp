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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ToDoItem.self)
        }
    }
}
