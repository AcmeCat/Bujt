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
    
    var categories: [String]
    
    @State private var name: String = ""
    @State private var selectedCategory: String = "personal"
    @State private var cost: Double = 0.0
    
    var body: some View {
        Form {
            TextField(text: $name) {
                Text("descprition")
            }
            Picker("category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            //Stepper("$\(cost)", value: $cost)
            TextField("Amount", value: $cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            Button("Submit") {
                saveEntry(name: name, category: selectedCategory, cost: cost)
            }
        }
    }
}

#Preview {
    AddView(categories: ["Personal", "Utilities"])
}

extension AddView {
    
    func saveEntry(name: String, category: String, cost: Double) {
        let entry = Entry(context: moc)
        entry.id = UUID()
        if (name == "") { return }
        entry.name = name
        entry.category = category
        if (cost == 0) { return }
        entry.cost = cost
        entry.date = Date()
        
        try? moc.save()
        
        dismiss()
    }
    
    
}
