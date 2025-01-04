//
//  PassengerInfoTextfieldComponent.swift
//  Volatus
//
//  Created by Engin Gülek on 4.01.2025.
//

import SwiftUI

struct PassengerInfoTextfieldComponent: View {
    let title:String
    let inputText:Binding<String>
    let error:(errorMessage:String,errorState:Bool)
    let type:UIKeyboardType
    let onChange:(String) -> Void

    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.semibold)
            TextField("Enter",text:inputText)
                .font(.system(size: 18))
                .padding(10) 
                .keyboardType(type)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                ).onChange(of: inputText.wrappedValue) { oldValue, newValue in
                    onChange(newValue)
                }
            error.errorState ?
            Text(error.errorMessage)
                .foregroundStyle(Color.red)
                .fontWeight(.semibold) : Text("")
        }.padding(.horizontal)
    }
}

