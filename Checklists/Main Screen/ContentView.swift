//
//  ContentView.swift
//  Checklists
//
//  Created by Jody Kocis on 10/28/19.
//  Copyright © 2019 Joseph Kocis. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Item.index, ascending: true)
        ]
    ) var items: FetchedResults<Item>
    
    @State private var showingAddItemView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink(
                        destination: DetailView2(item: item)
                            .navigationBarTitle("Reminder",
                                displayMode: .inline)
                    ) {
                        ItemView(item: item)
                            .onLongPressGesture {
                                self.save()
                            }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitle("Checklists",
                displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddItemView.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .imageScale(.medium)
                    })
            )
        }.sheet(isPresented: self.$showingAddItemView,
            content: {
                AddItemView()
                    .environment(\.managedObjectContext,
                        self.managedObjectContext)
            }
        )
        
    }
    
    func delete(at offsets: IndexSet) {
        let deleteItem = self.items[offsets.first!]
        self.managedObjectContext.delete(deleteItem)
        save()
    }
    
    func save() {
        print("Saving")
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error saving managedObjectContext: \(error)")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         return ContentView().environment(\.managedObjectContext, context)
    }
}
