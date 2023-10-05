//
//  CreateView.swift
//  SwiftDataToDo
//
//  Created by Mia on 5/10/2023.
//

import SwiftUI
import SwiftData

struct CreateView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @Query private var categories: [Category]
    
    @State private var item = Item()
    @State var selectedCategory: Category?
    
    
    var body: some View {
        List {
            Section("To do title") {
                TextField("Name", text: $item.title)
            }
            
            Section("General") {
                DatePicker("Choose a date",
                           selection: $item.timestamp)
                
                Toggle("Important?", isOn: $item.isCritical)
            }
            
            Section("Select a category") {
                Picker("", selection: $selectedCategory) {
                    
                    ForEach(categories) { category in
                        Text(category.title)
                            .tag(category as Category?)
                    }
                    
                    Text("None")
                        .tag(nil as Category?)
                    
                }
                .labelsHidden()
                .pickerStyle(.inline)
            }
            
            Section {
                Button("Create") {
                    save()
                    dismiss()
                }
            }
            
        }
        .navigationTitle("Create ToDo")
    }
}

private extension CreateView {
    
    func save() {
        context.insert(item)
        item.category = selectedCategory
        selectedCategory?.items?.append(item)
    }
}

#Preview {
    CreateView()
        .modelContainer(for: Item.self)
}
