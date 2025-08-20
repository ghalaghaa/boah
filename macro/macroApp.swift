//
//  macroApp.swift
//  macro
//
//  Created by Nouf on 29/04/2025.
//

import SwiftUI
import SwiftData

@main
struct macroApp: App {
    var body: some Scene {
        WindowGroup {
            MainPage()
                .modelContainer(for: Journal.self)
        }
        
    }
}

