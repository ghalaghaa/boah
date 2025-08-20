//
//  JournalViewModel.swift
//  macro
//
//  Created by Shahad Abdulmohsen on 10/11/1446 AH.
//

import Foundation
import SwiftData

class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = []

    func fetchJournals(context: ModelContext) {
        let descriptor = FetchDescriptor<Journal>()
        do {
            journals = try context.fetch(descriptor)
        } catch {
            print("⚠️ Fetch error:", error.localizedDescription)
        }
    }
}
