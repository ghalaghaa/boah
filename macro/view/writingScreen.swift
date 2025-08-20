//
//  writingScreen.swift
//  macro
//
//  Created by Nouf on 30/04/2025.
//

import SwiftUI
import SwiftData

struct writingScreen: View {

    @StateObject var textvm = textViewModel()
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var isNewUser: Bool = UserDefaults.standard.bool(forKey: "isNewUser") // Check if it's a new user
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = JournalViewModel()
    
    @Binding var editingJournal: Journal? //for editing

    var body: some View {
        NavigationView{
            ZStack {
                Color.background.ignoresSafeArea(edges: .all)
            ScrollView{
                VStack{
                    TextField("العنوان", text: $textvm.title)
                        .padding()
                        .background(Color.background)
                        .frame(height: 50)
                        .font(.system(size: 35, weight: .bold))
                        .foregroundStyle(.darkerBlue)
                    //signle line
                    //                TextField("عند كتابة تدوينتك، حاول أن تذكر أهمية الموقف، والأشخاص الذين شاركوك اللحظة، والمشاعر التي شعرت بها", text: $text, axis: .vertical)
                    //                    .padding()
                    //                    .background(Color.background)
                    //                    .multilineTextAlignment(.leading)
                    
                    ZStack(alignment: .topLeading) {
                        if textvm.text.isEmpty {
                            Text("فكّر أثناء كتابتك في أهمية ما حدث، من كان معك، وكيف شعرت في تلك اللحظة.")
                                .padding()
                                .foregroundStyle(.textPlaceHolder)
                                .font(.system(size: 20))
                        }

                        TextField("", text: Binding(
                            get: { textvm.text },
                            set: { newValue in
                                textvm.updateText(newValue)
                            }
                        ), axis: .vertical)
                            .padding()
                            .font(.system(size: 20))
                            .foregroundStyle(.darkerBlue)
                        
                    }
                }
                .padding(.bottom)
                .onAppear {
                    if let journal = editingJournal {
                        textvm.title = journal.title
                        textvm.text = journal.journal
                    }
                }
                    
                }
                
                if textvm.infoPopUp || textvm.analysisPopUp {
                    Color.black.opacity(0.5)
                                .ignoresSafeArea()
                                .transition(.opacity)
                                .zIndex(1)
                                .onTapGesture {
                                                withAnimation {
                                                    textvm.infoPopUp = false
                                                    textvm.analysisPopUp = false
                                                }
                                            }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if editingJournal == nil {
                            let newJournal = Journal( title: textvm.title,
                                                      journal: textvm.text,
                                                      date: Date(),
                                                      analysis: "",
                                                      isHidden: false, modifiedDate: Date())
                            context.insert(newJournal)
                        }
                        else {
                            editingJournal?.title = textvm.title
                            editingJournal?.journal = textvm.text
                            editingJournal = nil
                        }
                        textvm.text = ""
                        textvm.title = ""
                        dismiss()
                    }) {
                        Text("حفظ")
                            .font(.system(size: 20, weight: .bold))
//                            .shadow(color: .accent, radius: 0.1)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    ZStack{
                        HStack {
                            Spacer()
                            Spacer()
                            Spacer()
                            Button(action: {
                                textvm.undo()
                            }) {
                                Image("undo")
                                    .opacity(!textvm.canUndo() ? 0.5 : 1)
                            }
                            .disabled(!textvm.canUndo())
                            
                            Button(action: {
                                textvm.redo()
                            }) {
                                Image("redo")
                                    .opacity(!textvm.canRedo() ? 0.5 : 1)
                            }
                            .disabled(!textvm.canRedo())
                            if !textvm.text.isEmpty {
                                //                            ZStack{
                                VStack{
                                    Button(action: {
                                        withAnimation{
                                            textvm.infoPopUp.toggle()
                                        }
                                    }) {
                                        Image(systemName: "info.circle.fill")
                                            .zIndex(1)
                                            
                                    }
                                    .zIndex(3)
                                    
                                    
                                    if textvm.infoPopUp {
                                        VStack(spacing: 0){
                                            Triangle()
                                                            .fill(Color.white)
                                                            .frame(width: 20, height: 10)
                                                            .shadow(radius: 5)

                                            infoTab()
                                                .background(Color.background)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .shadow(radius: 5)
                                                .transition(.scale.combined(with: .opacity))
                                                .zIndex(1)
                                                .position(x: UIScreen.main.bounds.width / 2 - 150, y: UIScreen.main.bounds.height - 830)
                                        }

                                    }
                                    
                                    
                                }
                                .padding()
                                .zIndex(2)
//                                .clipShape(RoundedRectangle(cornerRadius: 12))
//                                .shadow(radius: 5)
                                
                                //                            }
                            }
                            Button(action: {
//                                textvm.analysisPopUp.toggle()
                            }) {
                                Image("analysis")
                                    .opacity(textvm.disableAnalysis() ? 0.5 : 1)
                            }
                            .disabled(textvm.disableAnalysis())
                            
                            if textvm.analysisPopUp {
                                VStack(spacing: 0){
                                    Triangle()
                                                    .fill(Color.white)
                                                    .frame(width: 20, height: 10)
                                                    .shadow(radius: 5)

                                    analysisTab()
                                        .background(Color.background)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .shadow(radius: 5)
                                        .transition(.scale.combined(with: .opacity))
                                        .zIndex(1)
                                        .position(x: UIScreen.main.bounds.width / 2 - 150, y: UIScreen.main.bounds.height - 830)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            .onAppear{
                if isNewUser {
                        textvm.analysisPopUp = true
                        UserDefaults.standard.set(false, forKey: "isNewUser")
                        isNewUser = false
                    }
            }
        }
    }
}

//#Preview {
//    writingScreen()
//}
