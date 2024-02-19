//
//  AddView.swift
//  Bujt
//
//  Created by Rory Allen on 18/2/2024.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var category: Category = .personal
    @State private var cost: Int16 = 0
    
    var body: some View {
        Form {
            TextField(text: $name) {
                Text("descprition")
            }
            Picker("category", selection: $category) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue)
                }
            }
            Stepper("$\(cost)", value: $cost)
            Button("Submit") {
                saveEntry(name: name, category: category, cost: cost)
            }
        }
    }
}

#Preview {
    AddView()
}

extension AddView {
    
    func saveEntry(name: String, category: Category, cost: Int16) {
        let entry = Entry(context: moc)
        entry.id = UUID()
        if (name == "") { return }
        entry.name = name
        entry.category = category.rawValue
        if (cost == 0) { return }
        entry.cost = cost
        entry.date = Date()
        
        try? moc.save()
        
        dismiss()
    }
    
    
}
