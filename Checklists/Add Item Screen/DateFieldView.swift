//
//  DateFieldView.swift
//  Checklists
//
//  Created by Jody Kocis on 2/8/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import SwiftUI
import Combine

struct DateFieldView: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var label: String
    var date: Binding<Date>
    
    var body: some View {
        VStack {
            Form {
                DatePicker(label, selection: date)
            }
        }
    }
}

struct DateFieldView_Previews: PreviewProvider {
    static var previews: some View {
        var dateField = Date()
        let dateBinding = Binding(get: {
            return dateField
        }, set: { date in
            dateField = date
        })
        
        return DateFieldView(
            label: "Date Label",
            date: dateBinding
        )
    }
}
