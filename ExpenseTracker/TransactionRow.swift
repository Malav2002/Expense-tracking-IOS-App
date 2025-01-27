//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Malav Patel on 3/19/24.
//

import SwiftUI

import SwiftUIFontIcon

struct TransactionRow: View{
    var transaction: Transaction
    
    var body: some View{
        HStack(spacing: 20){
            //Mark: transaction icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44,height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transaction.icon),fontsize: 24, color: Color.icon)
                }
            VStack(alignment:.leading,spacing: 6){
                
                //transactionMerchant
                Text(transaction.merchant )
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                //Mark: Transaction category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                //Mark: Transaction Date
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                
            }
            Spacer()
            //mark:transaction Amount
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
            
            
        }
        .padding([.top,.bottom], 8)
    }
    
}

struct TransactionRow_Previews:PreviewProvider{
    static var previews: some View{
        TransactionRow(transaction: transactionPreviewData)
        TransactionRow(transaction: transactionPreviewData)
            .preferredColorScheme(.dark)
    }
}
