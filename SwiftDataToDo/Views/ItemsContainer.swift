//
//  ItemsContainer.swift
//  SwiftDataToDo
//
//  Created by Mia on 6/10/2023.
//

import Foundation
import SwiftData

actor ItemsContainer {
    
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        let schema = Schema([Item.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: [configuration]);
        if shouldCreateDefaults {
            Category.defaults.forEach { container.mainContext.insert($0) }
            shouldCreateDefaults = false
        }
        return container
    }
    
}
