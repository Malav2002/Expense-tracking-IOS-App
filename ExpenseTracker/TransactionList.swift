//
//  TransactionList .swift
//  ExpenseTracker
//
//  Created by Malav Patel on 4/2/24.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM:  TransactionListViewModel
    var body: some View {
        VStack{
            List{
                //Mark: transaction group
                ForEach(Array(transactionListVM.groupTransactionByMonth()), id: \.key){ month, Transactions in
                    Section{
                        // Mark:transaction list
                        ForEach(Transactions) { Transactions in
                               TransactionRow(transaction: Transactions)
                        }
                        
                    } header: {
                        
                        // Mark: transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.Transactions = transactionListPreviewData
        return transactionListVM
    }()
    
        static var previews: some View{
        NavigationView{
            TransactionList()
        }
        .environmentObject(transactionListVM)
    }
}
