//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by King Justin on 6/30/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
    
    static func addNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(note)
        }
    }
    
    static func delNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    static func updateNote(noteToUpdate: Note, newNote: Note) {
        let realm = try! Realm()
        try! realm.write() {
            noteToUpdate.content = newNote.content
            noteToUpdate.title = newNote.title
            noteToUpdate.modificationTime = newNote.modificationTime
            
        }
    }
    
    static func retrieveNotes() -> Results<Note> {
        let realm = try! Realm()
        return realm.objects(Note).sorted("modificationTime", ascending: false)
    }

    
}

