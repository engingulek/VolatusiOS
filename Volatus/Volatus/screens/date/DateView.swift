//
//  DateView.swift
//  Volatus
//
//  Created by Engin Gülek on 29.12.2024.
//

import SwiftUI

struct DateListView<ViewModel:DateListViewModelProtocol>: View  {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 7)
    @StateObject  var viewModel:ViewModel
   
    var type:Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var sharedModel : SharedModel
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(Array(viewModel.mountCalender.keys.sorted()), id: \.self) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.mountCalender[index] ?? "")
                            .font(.callout)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.weekdays, id: \.self) { day in
                                Text(day)
                                    .font(.callout)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.gray)
                            }
                        }
                        let dates = viewModel.dateCalender[index] ?? []
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(dates, id: \.dayValue) { date in
                                if date == date && date.dayValue != "" {
                                    Text(date.dayValue)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(Color(hex:Color.calenderBackColor(type: date.type)))
                                        .font(.caption)
                                        .foregroundStyle(Color(hex:Color.calenderDateColor(type:date.type)))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .onTapGesture {
                                            if date.type != DateValueType.disable {
                                             let date = viewModel.selectDate(index: index,dayValue:date.dayValue)
                                                sharedModel.updateDate(type: type, date: date)
                                            
                                               
                                                dismiss()
                                            }
                                        }
                                    
                                } else {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle(type ? "Depature Date" : "Return Date")
        }.onAppear{
            
            viewModel.onAppear(
                getDepartureDate: sharedModel.departureDate,
                getReturnDate: sharedModel.returnDate, type: type)
        }
    }
}


