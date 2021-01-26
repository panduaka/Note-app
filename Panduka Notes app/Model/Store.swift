//
//  Store.swift
//  Panduka Notes app
//
//  Created by Panduka Wedisinghe on 24/1/21.
//

import Foundation

class Store {
    
    var notes = [(title: String, note: String)]()
    
    func addNote(title: String, note: String) {
        notes.append((title: title, note: note))
    }
    
    func editNote(title: String, note:String, index:Int) {
        notes[index] = (title:title, note:note)
    }
    
    func save() {
        
        let titles = notes.map { $0.title }
        let contents = notes.map { $0.note }

        UserDefaults.standard.setValue(titles, forKey: "titles")
        UserDefaults.standard.setValue(contents, forKey: "contents")
    }
}
