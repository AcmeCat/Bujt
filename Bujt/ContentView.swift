//
//  ContentView.swift
//  Bujt
//
//  Created by Rory Allen on 18/2/2024.
//

import CoreData
import SwiftUI

struct ContentView: View {
    
    @State private var shouldShowAdd = false
    @State private var shouldShowManage = false
    @State private var showingConfirmation = false
    @State private var deleteToggle = false
    
    
    @State private var personalBudgetMax: Int16 = Int16(UserDefaults.standard.integer(forKey: "personalBudgetMax"))
    @State private var groceryBudgetMax: Int16 = Int16(UserDefaults.standard.integer(forKey: "groceryBudgetMax"))
    @State private var savingsBudgetMax: Int16 = Int16(UserDefaults.standard.integer(forKey: "savingsBudgetMax"))
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "category = %@", Category.personal.rawValue)) var personalEntries: FetchedResults<Entry>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "category = %@", Category.groceries.rawValue)) var groceryEntries: FetchedResults<Entry>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "category = %@", Category.savings.rawValue)) var savingsEntries: FetchedResults<Entry>
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Remaining Cash")
                        .font(.title)
                    if personalBudgetMax > 0 {
                        HStack {
                            Text("Personal:")
                            Spacer()
                            Text("$\(personalBudgetMax - total(personalEntries))")
                        }
                    }
                    if groceryBudgetMax > 0 {
                        HStack {
                            Text("Groceries:")
                            Spacer()
                            Text("$\(groceryBudgetMax - total(groceryEntries))")
                        }
                    }
                    if savingsBudgetMax > 0 {
                        HStack {
                            Text("Savings:")
                            Spacer()
                            Text("$\(savingsBudgetMax - total(savingsEntries))")
                        }
                    }
                }
                if personalEntries.count > 0 {
                    Section {
                        ForEach(personalEntries) { entry in
                            HStack {
                                Text(entry.name ?? "Unknown")
                                Spacer()
                                Text("$\(entry.cost)")
                            }
                        }
                        .onDelete(perform: removePersonalEntry)
                    } header: {
                        Text("Personal: $\(total(personalEntries))")
                    }
                    
                }
                if groceryEntries.count > 0 {
                    Section {
                        ForEach(groceryEntries) { entry in
                            HStack {
                                Text(entry.name ?? "Unknown")
                                Spacer()
                                Text("$\(entry.cost)")
                            }
                        }
                        .onDelete(perform: removeGroceryEntry)
                    } header: {
                        Text("Groceries: $\(total(groceryEntries))")
                    }
                }
                if savingsEntries.count > 0 {
                    Section {
                        ForEach(savingsEntries) { entry in
                            HStack {
                                Text(entry.name ?? "Unknown")
                                Spacer()
                                Text("$\(entry.cost)")
                            }
                        }
                        .onDelete(perform: removeSavingsEntry)
                    } header: {
                        Text("Savings: $\(total(savingsEntries))")
                    }
                }
                Button {
                    restart()
                } label: {
                    Text("Start a new week")
                }
            }
            .padding()
            .toolbar{
                ToolbarItem (placement: .topBarLeading) {
                    addEntry
                }
                ToolbarItem (placement: .topBarTrailing) {
                    manageBudget
                }
            }
            .sheet(isPresented: $shouldShowAdd, onDismiss: dismissAdd){
                AddView()
            }
            .sheet(isPresented: $shouldShowManage, onDismiss: dismissManage){
                BudgetView()
            }
            .alert("Are you sure?", isPresented: $showingConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Yes, Delete It All!") { deleteAll() }
            }
        }
    }
}

#Preview {
    ContentView()
}

private extension ContentView {
    
    var addEntry: some View {
        Button {
            shouldShowAdd.toggle()
            print("add tapped...")
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
    func dismissAdd () {
        print("dismissed add view...")
    }
                    
    var manageBudget: some View {
        Button {
            shouldShowManage.toggle()
            print("add tapped...")
        } label: {
            Symbols.dollar
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
    func dismissManage () {
        personalBudgetMax = Int16(UserDefaults.standard.integer(forKey: "personalBudgetMax"))
        groceryBudgetMax = Int16(UserDefaults.standard.integer(forKey: "groceryBudgetMax"))
        savingsBudgetMax = Int16(UserDefaults.standard.integer(forKey: "savingsBudgetMax"))
    }
    
    func total (_ entries: FetchedResults<Entry>) -> Int16 {
        var total: Int16 = 0
        entries.forEach {
            total += $0.cost
        }
        return total
    }
    
    func restart() {
        showingConfirmation.toggle()
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Entry")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try moc.execute(deleteRequest)
            moc.reset()
            print("It's all gone!")
            deleteToggle.toggle()
        } catch let error as NSError {
            print("an error: ", error.localizedDescription)
        }
    }
    
    func removePersonalEntry(at indexSet: IndexSet) {
        for index in indexSet {
            let entry = personalEntries[index]
            moc.delete(entry)
        }
        try? moc.save()
    }
    
    func removeGroceryEntry(at indexSet: IndexSet) {
        for index in indexSet {
            let entry = groceryEntries[index]
            moc.delete(entry)
        }
        try? moc.save()
    }
    
    func removeSavingsEntry(at indexSet: IndexSet) {
        for index in indexSet {
            let entry = savingsEntries[index]
            moc.delete(entry)
        }
        try? moc.save()
    }
}
