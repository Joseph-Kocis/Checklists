//
//  LabelTextFieldView.swift
//  Checklists
//
//  Created by Jody Kocis on 11/28/19.
//  Copyright © 2019 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct LabelTextFieldView: View {
    var textField: Binding<String>
    
    var label: String
    var placeHolder: String
    
    var onCommit: () -> Void
    
    init(textField: Binding<String>, label: String, placeHolder: String) {
        self.textField = textField
        self.label = label
        self.placeHolder = placeHolder
        self.onCommit = {}
    }
    
    init(textField: Binding<String>, label: String, placeHolder: String, onCommit: @escaping () -> Void) {
        self.textField = textField
        self.label = label
        self.placeHolder = placeHolder
        self.onCommit = onCommit
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .padding(.top, 30)
            TextField(
                placeHolder,
                text: textField,
                onCommit: self.onCommit
            )
            .autocapitalization(.words)
            .background(
                Color(
                    red: 239.0/255.0,
                    green: 243.0/255.0,
                    blue: 244.0/255.0,
                    opacity: 1.0
                )
                .padding(.vertical, -10)
                .padding(.horizontal, -5)
            )
            .padding(.horizontal, 5)
            .padding(.top, 5)
            
        }
        .padding(.horizontal, 10)
    }
}

struct LabelTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        var textFieldString = ""
        let textField = Binding(get: {
            return textFieldString
        }, set: { textField in
            textFieldString = textField
        })
        
        return LabelTextFieldView(
            textField: textField,
            label: "Title",
            placeHolder: "New Item Title"
        )
    }
}
