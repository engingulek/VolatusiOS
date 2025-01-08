//
//  PassengerInfoScreen.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import SwiftUI

struct PassengerInfoScreen<ViewModel:PassengerInfoViewModelProtocol>: View {
    @ObservedObject var viewModel:ViewModel
    @EnvironmentObject private var sharedModel:SharedModel

    var body: some View {
        VStack{
            TicketInfoComponent(title: "Your Departure Flight")
            /*sharedModel.retrunTicketId != nil ? TicketInfoComponent(title: "Your Return Flight") : nil*/
            
            ScrollView {
                ForEach(viewModel.infoShowList,id: \.id) { info in
                    VStack {
                        HStack{
                           
                            Text("\(info.index + 1). \(info.passengerTitle)")
                                .fontWeight(.semibold)
                              
                            Spacer()
                            Image(systemName: info.showState ? ImageTheme.upArrow.rawValue : ImageTheme.downArrow.rawValue)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                            
                        } .padding()
                      
                    }.frame(maxWidth:.infinity)
                        .background(Color.white)
                        .onTapGesture {
                            viewModel.onActions(action: .onTappedPassenger(info.id))
                        }
                    info.showState ?
                    VStack(alignment:.leading){
                        PassengerInfoTextfieldComponent(
                            title: TextTheme.trId.rawValue,
                            inputText: $viewModel.passengerInfoList[info.id].trIdNumber,
                            error: viewModel.passengerInfoErrorList[info.id].trIdNumberError,
                            type:.numberPad) { text in
                                viewModel.onActions(action: .controlTrId(info.id))
                            }
                        
                        PassengerInfoTextfieldComponent(
                            title: TextTheme.name.rawValue,
                            inputText: $viewModel.passengerInfoList[info.id].name,
                            error: viewModel.passengerInfoErrorList[info.id].nameError,
                            type:.alphabet) { text in
                                viewModel.onActions(action: .controlName(info.id))
                            }
                        
                        
                        PassengerInfoTextfieldComponent(
                            title: TextTheme.surname.rawValue,
                            inputText: $viewModel.passengerInfoList[info.id].surname,
                            error: viewModel.passengerInfoErrorList[info.id].surnameError,
                            type:.alphabet) { text in
                                viewModel.onActions(action: .controlSurname(info.id))
                            }
                        
                        VStack(alignment:.center) {
                            Text(TextTheme.selectBirthdate.rawValue)
                                .fontWeight(.semibold)
                            DatePicker("",
                                       selection: $viewModel.passengerInfoList[info.id].birthDate,
                                       in: viewModel.passengerInfoList[info.id].dateRange.finish...viewModel.passengerInfoList[info.id].dateRange.start,
                                       displayedComponents: .date)
                            .frame(width:100)
                        }.frame(maxWidth:.infinity)
                       
                         
                    }.frame(maxWidth:.infinity)
                        .padding()
                       
                        .background(Color.white) : nil
                        
                    
                }
            }
            
        Spacer()
            
            
        }   .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
            .onAppear{
                viewModel.onAppear(passengerList: sharedModel.passengerList)
            }
        
    }
}

#Preview {
    PassengerInfoScreen(viewModel:PassengerInfoViewModel())
}
