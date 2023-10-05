//
//  ToDoItem.swift
//  SwiftDataToDo
//
//  Created by Mia on 5/10/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompleted: Bool
    
    @Relationship(deleteRule: .nullify, inverse: \Category.items)
    var category: Category?
    
    init(title: String = "",
         timestamp: Date = .now,
         isCritical: Bool = false,
         isCompleted: Bool = false) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
}
