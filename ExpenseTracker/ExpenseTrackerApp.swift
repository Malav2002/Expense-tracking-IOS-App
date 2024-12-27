//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Malav Patel on 3/18/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
