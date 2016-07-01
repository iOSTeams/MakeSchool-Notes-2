//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by King Justin on 6/30/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static func addNote(note: Note) {
        let realm = try! Realm()
        try! realm.write(){
            realm.add(note)
        }
    }
    
    static func deleteNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    static func retrieveNote() -> Results<Note>{
        let realm = try! Realm()
        return realm.objects(Note).sorted("modificationTime", ascending: false)
    }
    
    static func updateNote(oldNote: Note, newNote: Note) {
        var realm = try! Realm()
        try! realm.write() {
        oldNote.content = newNote.content
        oldNote.title = newNote.title
        oldNote.modificationTime = newNote.modificationTime
        }
    }
    
}