//
//  PassengerSelectView.swift
//  Volatus
//
//  Created by Engin Gülek on 31.12.2024.
//

import SwiftUI

struct PassengerSelectView<ViewModel:PassengerSelectViewModelProtocol>: View {
    @ObservedObject  var viewModel:ViewModel

   
    var body: some View {
        VStack {
            
            ForEach(0..<viewModel.passengerSelectState.passengerList.count,id:\.self){ index in
                VStack {
                    PassengerComponent(
                        passenger: viewModel.passengerSelectState.passengerList[index],
                        minusAction: {viewModel.onAction(action: .passengerCountMinus(index: index))},
                        plusAction: {viewModel.onAction(action: .passengerCountPlus(index:index))})
                }
                
                
              
             
            }
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text(viewModel.passengerSelectState.confirmButtonTitle)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            })
            .frame(maxWidth:.infinity)
            .frame(height:40)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
            
    
       
            .navigationTitle(viewModel.passengerSelectState.passengerTitle)
        }.onAppear{
            viewModel.opAppear()
        }
      
    }
}

#Preview {
    PassengerSelectView(viewModel: PassengerSelectViewModel())
}
