//
//  readJournal.swift
//  macro
//
//  Created by Nouf on 07/05/2025.
//
//ندف التاريخ واذا التايتل طويل ننزله سطر ثاني وبوكس البربل ننزله تحت شوي
//البوكس يصير بتن
//ونسوي الادت
import SwiftUI
import SwiftData
import LocalAuthentication

struct readJournal: View {
    @Binding var journal: Journal
    @State var isExpanded: Bool = false
    @State var currentPage = 0
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var confirmDelete = false
    @State private var isUnlocked: Bool = false
    @State var showWritingScreen: Bool = false
    @StateObject var textvm = textViewModel()
    @StateObject private var viewModel = JournalViewModel()
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.bg.ignoresSafeArea(edges: .all)
                VStack{
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            
                            Button(action: {
                                isExpanded.toggle()
                            }) {
                                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                                
                            }
                            Spacer()
                        }
//                        Text(journal.journal)
//                            .font(.system(size: 18))
//                            .foregroundStyle(.textBlue)
//                            .lineLimit(isExpanded ? nil : 3)
//                            .animation(.easeInOut, value: isExpanded)
                        if !journal.isHidden || isUnlocked {
                            Text(journal.journal)
                                .font(.system(size: 18))
                                .foregroundStyle(.textBlue)
                                .lineLimit(isExpanded ? nil : 3)
                                .animation(.easeInOut, value: isExpanded)
                        } else {
                            Text("يرجى التحقق باستخدام Face ID لعرض المذكرة.")
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding()
                    .background(Color.lightPurple)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    Spacer()
                    //analysis
                    VStack {
                        Text("انعكاس مذكراتك")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.darkerBlue)
                        
                        TabView(selection: $currentPage){
                            ForEach(0..<3) {
                                index in
                                ZStack {
                                   /* Rounded*/Rectangle(/*cornerRadius: 10*/)
                                        .fill(Color("stickyNote"))
                                        .frame(width: 240, height : 240)
                                        .shadow(radius: 5, y: 8)
                                    
                                    Text("ddd")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.black)
                                              
                                }
                                .tag(index)
                            }
                        }
                        .frame(height: 260)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
                        HStack(spacing: 8) {
                            ForEach(0..<3) {
                                index in
                                Circle()
                                    .fill(index == currentPage ? Color.darkPurple : .gray.opacity(0.4))
                                    .frame(width: 6, height: 6)
                            }
                        }
  
                    }
                    Spacer()
                }
                .alert("هل أنت متأكد من أنك تريد حذف المذكرة؟" , isPresented: $confirmDelete) {
                    Button("حذف", role: .destructive) {
                            modelContext.delete(journal)
                        dismiss()
                        }
                        Button("إلغاء", role: .cancel) { }
                }
                
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(journal.title)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.darkerBlue)
                        .padding(.trailing, 24)
                }
               
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 24){
                        
                        Button(action: {
                            authenticateWithFaceID()
                            
                        }) {
                            Image(systemName: "eye.slash.fill")
                        }
                        
                        Button(action: {
                            confirmDelete = true
                        }) {
                            Image(systemName: "trash")
                        }
                        
//                        NavigationLink(destination: writingScreen(editingJournal: journal)) {
//                            Image("pencil")
//                        }
                        NavigationLink(
                            destination: writingScreen(editingJournal: $textvm.editingJournal),
                                isActive: $showWritingScreen
                            ) {
                                EmptyView()
                            }
                            .hidden()
                        
                        Button(action: {
                            textvm.editingJournal = journal
                            showWritingScreen.toggle()
                        })
                        {
                            Image("pencil")
                        }
                        
                        
                    }
                }
                
            }
            
            
            
        }
        .onAppear {
            // هذا المكان الصح
        }
    }
    
    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "الرجاء استخدام Face ID لعرض المذكرة"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        print("فشل التحقق: \(authenticationError?.localizedDescription ?? "غير معروف")")
                    }
                }
            }
        } else {
            print("Face ID غير مدعوم: \(error?.localizedDescription ?? "غير معروف")")
        }
    }
}

//#Preview {
//    readJournal(journal: Journal(title: "hh", journal: "jjf  ejdn ehekfekhf fekhe ekf ekfhw jrjf ekfke fekhkef kehre fkefhke ekfhkef kefhe fjekfnje fkehfe fekhfkenf ekhfkenf rekfrkfb dekhfrbf ekhfekbf fekfdd", date: Date(), analysis: "dd", isHidden: false, modifiedDate: Date()))
//}

