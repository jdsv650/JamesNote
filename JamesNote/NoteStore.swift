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
        load()
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
    
    
    // how to save note -- how to create a note
    
    // MARK: Persistence
    
    private func archiveFilePath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as NSString
        let path = documentsDirectory.stringByAppendingPathComponent("NoteStore.plist")
        
        return path
    }
    
    func save()
    {
        NSKeyedArchiver.archiveRootObject(allNotes, toFile: archiveFilePath())
    }
    
    func load()  // fetch notes or create a new array of notes -- called in init()
    {
        let filePath = archiveFilePath()
        let fileManager = NSFileManager.defaultManager()
        
        if fileManager.fileExistsAtPath(filePath) {
            allNotes = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as [Note]
        }
        else
        {
            allNotes = [Note]()
        }
        
        
    }
    
}
