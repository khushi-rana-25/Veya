//
//  SwiftUIView.swift
//  EcoLab
//
//  Created by Khushi Rana on 25/12/25.
//

import SwiftUI

struct SymptomDetailView: View {
    let symptom: Symptom
    let color: Color
    
    var body: some View {
        ScrollView {

            VStack{
                TopView(symptom: symptom, color: color)
                
                OverViewView(symptom: symptom)
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Remedies & Tips")
                        .font(.title2)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                    
                    ForEach(symptom.remedies.indices, id: \.self) { index in
                        RemedyRowView(remedy: symptom.remedies[index])
                    }
                }
                .padding()
                
                DangerView()
                
                Text(.init(symptom.sources))
                    .padding()
                    .tint(.blue)
                    
            }
            .padding(.top, 50)
        }
    }
}

struct TopView: View{
    let symptom: Symptom
    let color: Color
    
    var body: some View {
        VStack(spacing: 20){
            Image(systemName: symptom.icon)
                .padding()
                .foregroundStyle(color)
                .background(color.opacity(0.2).clipShape(Circle()))
            
            Text(symptom.name)
                .font(.largeTitle)
                .foregroundStyle(color)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            HStack{
                ForEach(symptom.trimesters.indices, id: \.self) { index in
                    Text(symptom.trimesters[index])
                        .foregroundStyle(color)
                        .font(.caption.bold())
                        .padding()
                        .background(color.opacity(0.2))
                        .clipShape(.capsule)
                }
            }
        }
    }
}

struct OverViewView: View {
    let symptom: Symptom
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Overview")
                .font(.title2)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            
            VStack{
                Text("\"\(symptom.whatIsIt)\"")
                    .foregroundStyle(.primary)
                    .font(.headline)
                    .fontWeight(.medium)
                
                Divider()
                    .overlay(.black.opacity(0.6))
                
                Text(symptom.description)
                    .foregroundStyle(Color(#colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)))
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.2), radius: 3)
        }
        .padding(20)
    }
}

struct RemedyRowView: View {
    let remedy: String
    
    var body: some View {
        HStack(spacing: 15){
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color(#colorLiteral(red: 0, green: 0.5484743714, blue: 0.3741536736, alpha: 1)).opacity(0.8))
                    .frame(width: 30, height: 30)
                
                Text(remedy)
                    .font(.subheadline)
                    .fontWeight(.regular)
            
               Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.1), radius: 2)
    }
}

struct DangerView: View {
    var body: some View {

        VStack(alignment: .leading){
                HStack{
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color(#colorLiteral(red: 0.7575458288, green: 0, blue: 0.03144354746, alpha: 1)))
                        .frame(width: 30, height: 30)
                    
                    Text("When to Call a Doctor")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.7575458288, green: 0, blue: 0.03144354746, alpha: 1)))
                }
                
                Text("You cannot keep any food or fluids down for 24 hours.")
                    .foregroundStyle(Color(#colorLiteral(red: 0.5861611366, green: 0.2364613414, blue: 0.2301900387, alpha: 1)))
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .padding(5)
            }
            .padding()
            .background(LinearGradient(
                colors: [
                    Color(red: 0.99, green: 0.95, blue: 0.95),
                    Color(red: 1.0, green: 0.97, blue: 0.93),
                    Color(red: 0.99, green: 0.95, blue: 0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.2), radius: 2)
    }
}

