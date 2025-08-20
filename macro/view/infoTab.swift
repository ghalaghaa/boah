//
//  infoTab.swift
//  macro
//
//  Created by Nouf on 06/05/2025.
//

import SwiftUI

struct infoTab: View {
    var body: some View {
        VStack{
            Text("إرشادات الكتابة")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.darkerBlue)
            
            Text("فكّر أثناء كتابتك في أهمية ما حدث، من كان معك، وكيف شعرت في تلك اللحظة.")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.lightBlue)
                .frame(width: 175 , height: 54)
                .multilineTextAlignment(.center)
        }
        .cornerRadius(12)
        .frame(maxWidth: 175, maxHeight: 100)
    }
}

#Preview {
    infoTab()
}
