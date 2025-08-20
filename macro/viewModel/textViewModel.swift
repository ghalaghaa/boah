//
//  textViewModel.swift
//  macro
//
//  Created by Nouf on 05/05/2025.
//

import Foundation
class textViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var title: String = ""
    @Published var infoPopUp: Bool = false
    @Published var analysisPopUp : Bool = false
    var undoStack: [String] = []
    var redoStack: [String] = []
    var lastEditDate: Date?
    let typingInterval: TimeInterval = 1
    @Published var editingJournal: Journal? = nil
    
    func updateText(_ newText: String){
        guard newText != text else { return }
        let now = Date()
        if let lastEditDate = lastEditDate, now.timeIntervalSince(lastEditDate) < typingInterval {
            text = newText
        }
        else {
            undoStack.append(text)
            redoStack.removeAll()
            text = newText
        }
        self.lastEditDate = now
    }
    
    
    func undo(){
        guard let last = undoStack.popLast() else { return }
        redoStack.append(text)
        text = last
    }
    
    func redo(){
        guard let last = redoStack.popLast() else { return }
        undoStack.append(text)
        text = last
    }
    
    func canUndo() -> Bool {
        !undoStack.isEmpty
    }
    
    func canRedo() -> Bool {
           !redoStack.isEmpty
       }
    
    func disableAnalysis() -> Bool {
        if text.count < 100 {
            return true
        }
        return false
    }
}
