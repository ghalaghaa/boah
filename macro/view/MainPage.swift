//
//  MainPage.swift
//  macro
//
//  Created by Nouf on 29/04/2025.

//
import SwiftUI
import SwiftData

struct MainPage: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = JournalViewModel()

    var body: some View {
        Group {
            if viewModel.journals.isEmpty {
                EmptyState()
            } else {
                hasJournal()
            }
        }
        .onAppear {
            viewModel.fetchJournals(context: modelContext)
        }
    }
}

#Preview {
    MainPage()
}
//import SwiftUI
//import SwiftData
//
//struct MainPage: View {
//    var journals :[Journal] = []
//
//    var body: some View {
//        if journals.isEmpty {
//            EmptyState()
//        }else {
//            hasJournal()
//        }
//
//    }
//}
//
//#Preview {
//    MainPage()
//}
