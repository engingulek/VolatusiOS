//
//  DateView.swift
//  Volatus
//
//  Created by Engin Gülek on 29.12.2024.
//

import SwiftUI

struct DateListView<ViewModel:DateListViewModelProtocol>: View  {
    @StateObject  var viewModel:ViewModel
    var type:SelectedType
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var sharedModel : SharedModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                //MARK: Mount And Year List
                ForEach(Array(viewModel.uiState.mountCalender.keys.sorted()), id: \.self) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.uiState.mountCalender[index] ?? "")
                            .font(.callout)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        //MARK: Week List
                        LazyVGrid(columns: viewModel.uiState.columns) {
                            ForEach(viewModel.uiState.weekdays, id: \.self) { day in
                                Text(day)
                                    .font(.callout)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        let dates = viewModel.uiState.dateCalender[index] ?? []
                        LazyVGrid(columns: viewModel.uiState.columns, spacing: 10) {
                            //MARK: Days List
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
                                                sharedModel.updateDate(selectedType: type, date: date)
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
            .navigationTitle(viewModel.title(type: type))
        }.onAppear{
            
            viewModel.onAppear(
                getDepartureDate: sharedModel.departureDate,
                getReturnDate: sharedModel.returnDate, selectedType: .from)
        }
    }
}
