//
//  EmptyState.swift
//  macro
//
//  Created by Nouf on 29/04/2025.
//

import SwiftUI
import SwiftData
struct EmptyState: View {
    @State private var navigateToWriting = false
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = JournalViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea(edges: .all)
                VStack(spacing: 24){
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "person.circle")
                                .font(.system(size: 24))
                        }
                    }.padding(.horizontal)
                    
                    VStack(spacing:64){
                        
                        VStack(alignment: .leading){
                            HStack{
                                
                                Text("حديثًا")
                                    .font(.system( size: 22, weight: .bold))
                                    .foregroundStyle(.darkerBlue)
                                //                                .shadow(color: .darkerBlue, radius: 0.2)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            HStack{
                                Spacer()
                                ZStack{
                                    Image("dashedBorder")
                                        .resizable()
                                        .frame(width: 200.3, height: 295.04)
                                    
                                    VStack(alignment: .center, spacing: 18){
                                        
                                        Text("أنشئ مذكرة جديدة")
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundStyle(.darkBlue)
                                        Button(action: {
                                            navigateToWriting = true
                                            
                                        }) {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.system(size: 28))
                                                .foregroundStyle(.lavender)
                                        }
                                        NavigationLink(
                                            destination: writingScreen(),
                                            isActive: $navigateToWriting
                                        ) {
                                            EmptyView()
                                        }
                                        
                                    }
                                    .padding(.horizontal)
                                    
                                }
                                .padding(.horizontal)
                                Spacer()
                            }
                        } //end recent vsatck
                        
                        VStack(alignment: .leading, spacing: 42){
                            HStack{
                                
                                Text("مذكراتي")
                                    .font(.system( size: 22, weight: .bold))
                                    .foregroundStyle(.darkerBlue)
                                //                                .shadow(color: .darkerBlue, radius: 0.2)
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundStyle(.lavender)
                                }
                                
                            }
                            .padding(.horizontal)
                            
                            HStack{
                                Spacer()
                                VStack(alignment: .center, spacing: 14){
                                    Image("bookIcon")
                                    Text("لا يوجد لديك أي مذكرات")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.darkBlue)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                        } //end my journals vstack
                        
                    } //vstack without top bar
                    Spacer()
                }//big vstack
                
            }
        }
        .onAppear {
            // هذا المكان الصح
        }
    }
}

#Preview {
    EmptyState()
}
