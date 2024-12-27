//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Malav Patel on 3/18/24.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    //var demoData: [Double]=[8, 2, 4, 6, 12, 9, 2]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing:24){
                    //title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //chart
                    let data = transactionListVM.accumulateTransactions()
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1 ?? 0
                        CardView{
                            VStack{
                                ChartLabel (totalExpenses.formatted(.currency(code: "USD")), type:.title, format: "$%02f")
                                
                                LineChart()
                            }
                            .background(Color.systemBackground)
                               
                            
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4),Color.icon)))
                        .frame(height: 300)
                        
                        
                    }
                    
                    
                    recentTransactionList()
                    
                }
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                
            }
            .background(Color.bg)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                //mark :notification icon
                ToolbarItem{
                    Image(systemName:"bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.Icon, .primary)
                    
                }
            }
            
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Preveiws:PreviewProvider{
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.Transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View{
        ContentView()
        
            .environmentObject(transactionListVM)
    }
}
