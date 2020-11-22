//
//  AddItemView.swift
//  Checklists
//
//  Created by Jody Kocis on 11/26/19.
//  Copyright © 2019 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var itemTitle = ""
    @State var itemDescription = ""
    
    let horizontalPadding: CGFloat = 10
    let topPadding: CGFloat = 15
    
    var body: some View {
        NavigationView {
            VStack {
                LabelTextFieldView(
                    textField: $itemTitle,
                    label: "Title",
                    placeHolder: "New Item Title"
                )
                .padding(.horizontal, horizontalPadding)
                .padding(.top, topPadding)
                
                LabelTextFieldView(
                    textField: $itemDescription,
                    label: "Description",
                    placeHolder: "New Item Description"
                )
                .padding(.horizontal, horizontalPadding)
                .padding(.top, topPadding)
                
                Spacer()
            }
            .navigationBarTitle("Create a New Item",
                displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentationMode
                            .wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    }),
                trailing:
                    Button(action: {
                        
                        let newItem = Item(context: self.managedObjectContext)
                        newItem.title = self.itemTitle
                        newItem.itemDescription = self.itemDescription
                        newItem.createdDate = Date()
                        newItem.completed = false
                        newItem.dueDate = Date()
                        newItem.index = 1
                        newItem.remindDate = Date()
                        
                        do {
                            try self.managedObjectContext
                                .save()
                        } catch {
                            print("Error saving managedObjectContext: \(error)")
                        }
                        
                        self.presentationMode
                            .wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                    })
            )
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         return AddItemView().environment(\.managedObjectContext, context)
    }
}
