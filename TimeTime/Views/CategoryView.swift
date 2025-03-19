//
//  CategoryView.swift
//  TimeTime
//
//  Created by levin marvyn on 11/03/2025.
//

import SwiftUI

struct CategoryView: View {
    @State private var selectedTimeUnit = "Jours"
    let timeUnits = ["Jours", "Semaines", "Années"]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("logoTimeTime")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 70)
                        .padding(.vertical, 20)
                    
                                        
                    Picker("Sélectionnez une unité de temps", selection: $selectedTimeUnit) {
                                        ForEach(timeUnits, id: \.self) { unit in
                                            Text(unit)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .padding()
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CategoryView()
}
