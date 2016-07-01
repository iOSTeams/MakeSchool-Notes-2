//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    @IBOutlet weak var noteContentTextView: UITextView!
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        noteTitleTextField.text = ""
        noteContentTextView.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                print ("Transitioning to display note")
            }
            else if identifier == "addNote" {
                print ("Add note")
                let note = Note()
                // 2
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text
                // 3
                note.modificationTime = NSDate()
            }
            else if identifier == "save" {
                
                let note = Note()
                if note.title.characters.count > 0 || note.content.characters.count > 0 {
                    print("Note saved")
                    note.title = noteTitleTextField.text ?? ""
                    note.content = noteContentTextView.text ?? ""
                    print("Title of note saved is \(note.title)")
                    note.content = noteContentTextView.text
                    note.modificationTime = NSDate()
                    
                    //Add note to array of notes
                    let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
                    listNotesTableViewController.notes.append(note)
                }
                
     
            }
        }
    }
    
}
