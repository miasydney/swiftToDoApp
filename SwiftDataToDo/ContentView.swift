//
//  ContentView.swift
//  SwiftDataToDo
//
//  Created by Mia on 5/10/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
        
        @State private var showCreate = false
        @State private var toDoEdit: ToDoItem?
        @Query(
           filter: #Predicate<ToDoItem> {$0.isCompleted == false},
            sort: \ToDoItem.timestamp
       ) private var items: [ToDoItem]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    HStack {
                       VStack(alignment: .leading) {
                           
                           if item.isCritical {
                               Image(systemName: "exclamationmark.3")
                                   .symbolVariant(.fill)
                                   .foregroundColor(.red)
                                   .font(.largeTitle)
                                   .bold()
                           }
                           
                           Text(item.title)
                               .font(.largeTitle)
                               .bold()
                           
                           Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                               .font(.callout)
                       }
                       
                       Spacer()
                       
                       Button {
                           withAnimation {
                               item.isCompleted.toggle()
                           }
                       } label: {
                           
                           Image(systemName: "checkmark")
                               .symbolVariant(.circle.fill)
                               .foregroundStyle(item.isCompleted ? .green : .gray)
                               .font(.largeTitle)
                       }
                       .buttonStyle(.plain)
                       
                   }
                    .swipeActions {
                        Button(role: .destructive) {
                            
                            withAnimation {
                                context.delete(item)
                            }
                            
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .symbolVariant(.fill)
                        }
                        
                        Button {
                            toDoEdit = item
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
                }
            }
            .navigationTitle("My To Do List")
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showCreate.toggle()
                        }, label: {
                            Label("Add Item", systemImage: "plus")
                        })
                    }
                }
                .sheet(isPresented: $showCreate, content: {
                    NavigationStack {
                        CreateView()
                    }
                    .presentationDetents([.medium])
                })
                .sheet(item: $toDoEdit) {
                    toDoEdit = nil
                } content: { item in
                    UpdateToDoView(item: item)
                }
        }

    }
}

//#Preview {
//    ContentView()
//}
