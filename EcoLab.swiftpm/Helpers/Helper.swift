//
//  File.swift
//  EcoLab
//
//  Created by Khushi Rana on 27/12/25.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class Helper{
    static let shared = Helper()
    
    static let timestampFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        df.doesRelativeDateFormatting = false
        return df
    }()
    
    func formatted(_ date: Date) -> String {
        Self.timestampFormatter.string(from: date)
    }
    
    func severityColor(_ severity: String) -> Color {
            if severity == "Mild" { return .green }
            else if severity == "Moderate" { return .orange }
            else { return .red }
        }
    
    @MainActor
    func renderPDF(logs: [LogEntry]) -> URL {
            let pdfView = PdfReportView(logs: logs)
                .frame(width: 595, height: 842)
            
            let renderer = ImageRenderer(content: pdfView)
            let url = URL.documentsDirectory.appending(path: "EcoLab-Report.pdf")
            
            renderer.render { size, context in
                var box = CGRect(x: 0, y: 0, width: 595, height: 842)
                
                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                    return
                }
                
                pdf.beginPDFPage(nil)
                context(pdf)
                pdf.endPDFPage()
                pdf.closePDF()
            }
            
            return url
        }
    
}
