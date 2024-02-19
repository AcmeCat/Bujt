//
//  Categories.swift
//  Bujt
//
//  Created by Rory Allen on 18/2/2024.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: Self {self}
    case groceries, personal, savings, utilities
}
