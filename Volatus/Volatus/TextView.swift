//
//  TextView.swift
//  Volatus
//
//  Created by Engin Gülek on 29.12.2024.
//

import SwiftUI

struct TestView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 7) // 7 sütunlu grid
    let weekDays = ["Pzt", "Salı", "Çrş", "Per", "Cuma", "Ctesi", "Pazar"]

    // Bugünden başlayarak aylara bölünmüş tarihleri oluşturur ve doğru hizalar
    func generateDatesByMonth() -> [String: [String?]] {
        let calendar = Calendar.current
        let today = Date()
        let endDate = calendar.date(byAdding: .month, value: 3, to: today)!

        var datesByMonth: [String: [String?]] = [:]
        var currentDate = today

        while currentDate <= endDate {
            let components = calendar.dateComponents([.day, .month, .year, .weekday], from: currentDate)
            if let day = components.day, let month = components.month, let year = components.year, let weekday = components.weekday {
                let monthKey = "\(month)/\(year)"

                // Eğer yeni bir ay başlıyorsa
                if datesByMonth[monthKey] == nil {
                    // Ayı başlat ve gerekli boşlukları ekle
                    let weekdayOffset = weekday - 2 // Haftayı Pazartesi ile başlat
                    let offset = weekdayOffset < 0 ? 6 : weekdayOffset
                    datesByMonth[monthKey] = Array(repeating: nil, count: offset)
                }

                // Günü ekle
                datesByMonth[monthKey]?.append("\(day)")
            }

            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return datesByMonth
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(Array(generateDatesByMonth().keys.sorted()), id: \.self) { month in
                    let dates = generateDatesByMonth()[month] ?? []

                    VStack(alignment: .leading, spacing: 10) {
                        // Ay Başlığı
                        Text(month)
                            .font(.title)
                            .bold()
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Haftanın Günleri
                        LazyVGrid(columns: columns) {
                            ForEach(weekDays, id: \.self) { day in
                                Text(day)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        
                        // Tarihler
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(dates, id: \.self) { date in
                                if let date = date {
                                    Text(date)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(10)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                } else {
                                    // Boş Hücreler
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
        }
        .navigationTitle("Takvim")
    }
}

#Preview {
    TestView()
}
