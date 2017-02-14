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
    fileprivate struct Static {
        static let instance : NoteStore = NoteStore()
    }
    
    class func shared() -> NoteStore {    // class func read as "static func" ..... !!!!!!!!
        return Static.instance
    }
    
    fileprivate init() {
        load()
    }
    
    fileprivate var allNotes : [Note]!
    
    // MARK: CRUD methods - Create, Read, Update, Delete
    
    func createNote() -> Note {
        
        let note = Note()
        allNotes!.append(note)
        return note
    }
    
    func createNote(_ theNote: Note) {
        allNotes.append(theNote)
    }
    
    func getNote(_ index:Int) -> Note {
        return allNotes[index]
    }
    
    func count() -> Int {
        return allNotes.count
    }
    
    // no need to update, notes passed by reference
    
    func delete(_ index:Int) {
        allNotes.remove(at: index)
    }
    
    
    // how to save note -- how to create a note
    
    // MARK: Persistence
    
    fileprivate func archiveFilePath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("NoteStore1.plist")
        
        return path
    }
    
    func save()
    {
        NSKeyedArchiver.archiveRootObject(allNotes, toFile: archiveFilePath())
    }
    
    func load()  // fetch notes or create a new array of notes -- called in init()
    {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
        
            allNotes = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [Note]
        }
        else
        {
            allNotes = [Note]()
        }
        
        
    }
    
}
