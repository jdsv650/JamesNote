//
//  NoteStore.swift
//  JamesNote
//
//  Created by James on 1/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

class NoteStore
{
    // Mark: Singleton Pattern
    private struct Static {
        static let instance : NoteStore = NoteStore()
    }
    
    
    class func shared() -> NoteStore {    // class func read as "static func" ..... !!!!!!!!
        return Static.instance
    }
    
    private init() {
        allNotes = [Note]()
    }
    
    private var allNotes : [Note]!
    
    // MARK: CRUD methods - Create, Read, Update, Delete
    
    func createNote() -> Note {
        
        var note = Note()
        allNotes!.append(note)
        return note
    }
    
    func createNote(theNote: Note) {
        allNotes.append(theNote)
    }
    
    func getNote(index:Int) -> Note {
        return allNotes[index]
    }
    
    func count() -> Int {
        return allNotes.count
    }
    
    // no need to update, notes passed by reference
    
    func delete(index:Int) {
        allNotes.removeAtIndex(index)
    }
    
    
    
    
}
