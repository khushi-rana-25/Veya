//
//  SwiftUIView.swift
//  EcoLab
//
//  Created by Khushi Rana on 26/12/25.
//

import SwiftUI

struct SymptomsHistoryView: View {
    var body: some View {
        NavigationStack{
            List{
                ForEach(0..<5) { index in
                    SymnptomHistoryRowView()
                }
                .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Journal")
        }
    }
}

struct SymnptomHistoryRowView: View {
    var body: some View {
        
        HStack(spacing: 20){
            Image(systemName: "bandage.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(.blue)
                .background(
                    Circle()
                        .fill(.blue.opacity(0.3))
                        .frame(width: 40, height: 40)
                )
            
            VStack(alignment: .leading){
                Text("Migraine")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("Today, 9:41 AM")
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("Severe")
                .foregroundStyle(.blue)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 27)
                        .strokeBorder(.blue, lineWidth: 2)
                )
        }
    }
}

#Preview {
    SymptomsHistoryView()
}
