//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift
class DisplayNoteViewController: UIViewController {
    
    var note: Note?
    
    @IBOutlet weak var noteContentTextView: UITextView!
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = note {
            // 2
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            // 3
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        
        if let identifier = segue.identifier {
            if identifier == "save" {
                if let note = note {
                    let newNote = Note()
                    newNote.title = noteTitleTextField.text ?? ""
                    newNote.content = noteContentTextView.text ?? ""
                    RealmHelper.updateNote(note, newNote: newNote)
                }
            }
//            else if (noteContentTextView.text?.isEmpty) || (noteTitleTextField.text?.characters.count > 0) {
//                let note = Note()
//                note.title = noteTitleTextField.text ?? ""
//                note.content = noteContentTextView.text ?? ""
//                note.modificationTime = NSDate()
//                RealmHelper.addNote(note)
//            }
            listNotesTableViewController.notes = RealmHelper.retrieveNote()
        }
    }
}




