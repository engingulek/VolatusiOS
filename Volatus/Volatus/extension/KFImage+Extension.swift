//
//  KFImage+Extension.swift
//  Volatus
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation
import SwiftUI
import Kingfisher

import SwiftUI
import Kingfisher

extension KFImage {
    static func from(url: URL?, placeholder: AnyView? = nil, frame: CGFloat = 40) -> some View {
      
        return KFImage(url)
            .placeholder {
                placeholder ?? AnyView(ProgressView())
            }
            .resizable()
            .cacheMemoryOnly()
            .scaledToFill()
            .frame(width: frame, height: frame)
            .clipped()
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

