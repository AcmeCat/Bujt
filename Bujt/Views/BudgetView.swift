//
//  BudgetView.swift
//  Bujt
//
//  Created by Rory Allen on 18/2/2024.
//

import SwiftUI

struct BudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach($viewModel.budgetArray) { budget in
                        BudgetStepperView(budget: budget)
                    }
                    Button("Submit") {
                        viewModel.submit()
                        dismiss()
                    }
                }
                AddCategoryView(viewModel: viewModel)
            }
            .navigationTitle("Edit Budget")
        }
    }
}

struct AddCategoryView: View {
    @State private var categoryName = ""
    @ObservedObject var viewModel: BudgetViewModel
    
    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TextField("New Category", text: $categoryName)
        Button ("Add") {
            viewModel.addCategory(name: categoryName)
        }
    }
}

struct BudgetStepperView: View {
    @Binding var budget: CategoryBudget
    var body: some View {
        Stepper("\(budget.category): $\(budget.budget)", value: $budget.budget, step: 10)
    }
}
