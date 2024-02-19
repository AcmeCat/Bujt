//
//  BudgetView.swift
//  Bujt
//
//  Created by Rory Allen on 18/2/2024.
//

import SwiftUI

struct BudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var personalBudget: Int16 = Int16(UserDefaults.standard.integer(forKey: "personalBudgetMax"))
    @State private var groceryBudget: Int16 = Int16(UserDefaults.standard.integer(forKey: "groceryBudgetMax"))
    @State private var babyBudget: Int16 = Int16(UserDefaults.standard.integer(forKey: "babyBudgetMax"))
    
    var body: some View {
        NavigationView {
            Form {
                Stepper("For personal use: $\(personalBudget)", value: $personalBudget, step: 10)
                Stepper("For groceries: $\(groceryBudget)", value: $groceryBudget, step: 10)
                Stepper("For baby nesting: $\(babyBudget)", value: $babyBudget, step: 10)
                Button("Submit") {
                    submit()
                }
            }
            .navigationTitle("Edit Budget")
        }
    }
}

#Preview {
    BudgetView()
}

extension BudgetView {
    func submit() {
        UserDefaults.standard.set(personalBudget, forKey: "personalBudgetMax")
        UserDefaults.standard.set(groceryBudget, forKey: "groceryBudgetMax")
        UserDefaults.standard.set(babyBudget, forKey: "babyBudgetMax")
        
        dismiss()
    }
}
