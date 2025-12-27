//
//  SwiftUIView.swift
//  EcoLab
//
//  Created by Khushi Rana on 25/12/25.
//

import SwiftUI
import SwiftData

enum SymptomMode: String {
    case mild = "Mild"
    case moderate = "Moderate"
    case severe = "Severe"
}

struct LogSymptomView: View {
    let symptom: Symptom
    let color: Color
    @State private var sliderValue: Double = 0
    @State private var isPulsing: Bool = false
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack{
            
            topView
            
            Spacer()
            
            pulseView
            
            Spacer()
            
            bottomView
        }
        .padding()
    }
    
    var currentMode: SymptomMode {
        if sliderValue < 0.33 { return .mild }
        else if sliderValue < 0.66 { return .moderate }
        else { return .severe }
    }
    
    var activeColor: Color {
        if sliderValue < 0.33 { return color }
        else if sliderValue < 0.66 { return .orange }
        else { return .red }
    }
    
    var animationDuration: Double {
        return 2.0 - (sliderValue * 1.5)
    }
    
    var topView: some View {
        VStack  {
            Text("How is your \(symptom.name)?")
                .foregroundStyle(.primary)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            Text("Drag the slider to match your feeling")
                .foregroundStyle(.secondary)
                .font(.headline)
                .padding()
        }
    }
    
    var pulseView: some View {
        ZStack {
            Circle()
                .fill(activeColor)
                .frame(width: 150, height: 150)
                .blur(radius: 50)
                .opacity(0.6)
                .scaleEffect(isPulsing ? 1.3 + (sliderValue * 0.5) : 1.0)
            
            Image(systemName: symptom.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(activeColor)
                .scaleEffect(isPulsing ? 1.3 : 1.0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: animationDuration).repeatForever(autoreverses: true)) {
                isPulsing = true
            }
        }
    }
    
    var bottomView: some View {
        VStack{
            Text(currentMode.rawValue)
                .font(.headline)
                .foregroundStyle(currentMode == .mild ? .green : (currentMode == .moderate ? .yellow : .red))
            
            Slider(value: $sliderValue, in: 0...1)
                .tint(activeColor)
            HStack{
                Text("Mild")
                Spacer()
                Text("Severe")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            
            Button {
                viewModel.addLog(symptomName: symptom.name, severity: currentMode.rawValue, context: modelContext)
                
                dismiss()
            }
            label: {
                Text("Log Symptom")
                    .padding()
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(activeColor.gradient)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
        }
    }
}

