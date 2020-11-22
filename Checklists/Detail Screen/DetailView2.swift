//
//  DetailView2.swift
//  Checklists
//
//  Created by Jody Kocis on 2/20/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct DetailView2: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var item: Item
    
    var itemTitle: Binding<String> {
        Binding<String> (
            get: { self.item.title ?? "" },
            set: { newTitle in
                self.item.title = newTitle
                self.save()
            }
        )
    }
    
    var itemDescription: Binding<String> {
        Binding<String> (
            get: { self.item.itemDescription ?? "" },
            set: { newDescription in
                self.item.itemDescription = newDescription
                self.save()
            }
        )
    }
    
    @State var itemDueDate: Date = Date()
    var itemDueDateProxy: Binding<Date> {
        Binding<Date> (
            get: { self.item.dueDate ?? Date() },
            set: { newDate in
                self.itemDueDate = newDate
                self.item.dueDate = newDate
                self.save()
            }
        )
    }
    
    let horizontalPadding: CGFloat = 10
    let topPadding: CGFloat = 15
    
    init(item: Item) {
        self.item = item
        self.itemDueDate = item.dueDate ?? Date()
    }
    
    // TODO: -- https://dev.to/kevinmaarek/forms-made-easy-with-swiftui-3b75
    
    var body : some View {
        //VStack {
            /*LabelTextFieldView(
                textField: itemTitle,
                label: "Title",
                placeHolder: "No Item Title"
            )
            .padding(.horizontal, horizontalPadding)
            .padding(.top, topPadding)
            
            LabelTextFieldView(
                textField: itemDescription,
                label: "Description",
                placeHolder: "No Item Description"
            )
            .padding(.horizontal, horizontalPadding)
            .padding(.top, topPadding)
            
            DateFieldView(
                label: "Due Date",
                date: itemDueDateProxy
            )
            .padding(.horizontal, horizontalPadding)
            .padding(.top, topPadding)
            
            Spacer()*/
        //}
        
        VStack {
            Form {
                Section(header: Text("Title")) {
                    TextField(
                        "No Item Title",
                        text: itemTitle
                    )
                }
                
                Section(header: Text("Description")) {
                    TextField(
                        "No Item Description",
                        text: itemDescription
                    )
                }
            }
        }
        
    }
    
    func save() {
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error saving managedObjectContext: \(error)")
        }
    }
}

struct DetailView2_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let item = Item(context: context)
        item.title = "New Item"
        item.itemDescription = "Description"
        item.completed = false
        item.remindDate = Date()
        item.dueDate = Date()
        
        return DetailView2(item: item)
    }
}
