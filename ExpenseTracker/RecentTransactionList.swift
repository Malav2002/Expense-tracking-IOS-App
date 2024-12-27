//
//  recentTransactionList.swift
//  ExpenseTracker
//
//  Created by Malav Patel on 3/28/24.
//

import SwiftUI

struct recentTransactionList: View {
    @EnvironmentObject var TransactionListVM: TransactionListViewModel
    var body: some View {
        VStack{
            HStack{
                // Mark:header
                Text("Recent Transactions")
                    .bold()
                Spacer()
                // Mark:headerLink
                NavigationLink {
                    TransactionList()
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                        
                        
                    }
                    .foregroundColor(Color.text)
                    
                }
            }
            .padding(.top)
            //Mark: Recent transaction List
            ForEach(Array(TransactionListVM.Transactions.prefix(5).enumerated()),id: \.element){ index, transaction in
                TransactionRow(transaction: transaction)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2),radius: 10,x:0,y:5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.Transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View{
        recentTransactionList()
            .environmentObject(transactionListVM)
       
    }
}
