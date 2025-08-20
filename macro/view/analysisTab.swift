//
//  analysisTab.swift
//  macro
//
//  Created by Nouf on 06/05/2025.
//

import SwiftUI

struct analysisTab: View {
    var body: some View {
        VStack{
            Text("إيقونة التحليل")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.darkerBlue)
            
            Text("استخدم هذه الأيقونة لتحليل محتوى مذكرتك. يجب أن يكون المحتوى أكثر من ٣ أسطر.")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.lightBlue)
                .frame(width: 175 , height: 80)
                .multilineTextAlignment(.center)
        }
        .cornerRadius(12)
      
        
        .frame(maxWidth: 175, maxHeight: 100)
    }
}

#Preview {
    analysisTab()
}
