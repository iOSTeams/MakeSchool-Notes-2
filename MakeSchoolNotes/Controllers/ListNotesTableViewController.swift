//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    
    var notes: Results<Note>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var notesPerMonth: [[Note]] = []

    
    @IBAction func backButton(sender: UIBarButtonItem) {
        print ("back")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = RealmHelper.retrieveNote()
    }
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        print ("Unwinded")
    }
    
    //Number of cells
    // Both methods are part of the UITableViewDataSource Protocol, these are methods we are implementing in order to answer how many cells should be displayed and what information each displays
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
//        return 3
    }
//
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Hello"
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
//        return self.notesPerMonth.count
    }
    
    // Content
    // This type of interaction is called a delegate pattern where one object (the table view) delegates to another object (listnotestableviewcontroller class) to help it accomplish a task
    // Delegate is, in this case, what happens when the cell is tapped 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("cellForRowAtIndexPath - row: \(indexPath.row), section: \(indexPath.section)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        // Only works when I add "as! ListNotesTableViewCell", only then will cell. have autocompletes for notestitle and notemodtime
        
        
        let row = indexPath.row
//        let section = indexPath.section
        
        
        let note = notes[row]
        
        cell.notesTitleLabel.text = note.title
        cell.notesModTime.text = note.modificationTime.convertToString()
        
        
        
//        var image : UIImage = UIImage(named:"test.jpeg")!
//        cell.notesImage.image = image
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                print ("Transitioning to display note")
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let note = notes[indexPath.row]
                // 3
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                // 4f
                displayNoteViewController.note = note
                
            }
            else if identifier == "addNote" {
                print ("Add note button pressed")
            }
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 2
        if editingStyle == .Delete {
            // 3
            tableView.allowsMultipleSelection = true
            RealmHelper.deleteNote(notes[indexPath.row])
//            notes.removeAtIndex(indexPath.row)
            // 4
            tableView.reloadData()
        }
    }
}