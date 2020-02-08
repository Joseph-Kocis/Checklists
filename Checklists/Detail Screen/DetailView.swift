//
//  DetailView.swift
//  Checklists
//
//  Created by Jody Kocis on 11/28/19.
//  Copyright © 2019 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var item: Item
    
    //@State var itemTitle: String = ""
    //@State var itemDescription: String = ""
    
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
    
    init(item: Item) {
        self.item = item
        //self.itemTitle = item.title ?? ""
        //self.itemDescription = item.itemDescription ?? ""
        self.itemDueDate = item.dueDate ?? Date()
    }
    
    var body : some View {
        VStack {
            LabelTextFieldView(
                textField: itemTitle,
                label: "Title",
                placeHolder: "No Item Title",
                onCommit: {
                    //self.item.title = self.itemTitle
                    //self.save()
                }
            )
            LabelTextFieldView(
                textField: itemDescription,
                label: "Description",
                placeHolder: "No Item Description",
                onCommit: {
                    //self.item.itemDescription = self.itemDescription
                    //self.save()
                }
            )
            DateFieldView(
                label: "Due Date",
                date: itemDueDateProxy
            )
            
            Spacer()
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let item = Item(context: context)
        item.title = "New Item"
        item.itemDescription = "Description"
        item.completed = false
        item.remindDate = Date()
        item.dueDate = Date()
        
        return DetailView(item: item)
    }
}
