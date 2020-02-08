//
//  ItemView.swift
//  Checklists
//
//  Created by Jody Kocis on 11/26/19.
//  Copyright © 2019 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title ?? "Unknown")
                    .font(.headline)
                Text(item.itemDescription ?? "")
                    .font(.subheadline)
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let item = Item(context: context)
        item.title = "New Item"
        item.itemDescription = "Description"
        item.completed = false
        item.remindDate = Date()
        item.dueDate = Date()
        
        return ItemView(item: item)
    }
}
