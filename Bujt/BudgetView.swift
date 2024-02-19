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
    @State private var savingsBudget: Int16 = Int16(UserDefaults.standard.integer(forKey: "savingsBudgetMax"))
    
    var body: some View {
        NavigationView {
            Form {
                Stepper("For personal use: $\(personalBudget)", value: $personalBudget, step: 10)
                Stepper("For groceries: $\(groceryBudget)", value: $groceryBudget, step: 10)
                Stepper("For savings: $\(savingsBudget)", value: $savingsBudget, step: 10)
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
        UserDefaults.standard.set(savingsBudget, forKey: "savingsBudgetMax")
        dismiss()
    }
}
