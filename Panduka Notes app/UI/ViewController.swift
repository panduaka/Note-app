//
//  ViewController.swift
//  Panduka Notes app
//
//  Created by Panduka Wedisinghe on 23/1/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var noNotesLabel: UILabel!
    
    private let cellID = "cell"
    
    private var store = Store()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self

        loadData()

        title = "My Notes"
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @IBAction func didTapAddNewNote(){
        if table.isEditing {
            return
        }
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? NoteEntryViewController else {
            return
        }
        vc.title = "New Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.store.addNote(title: noteTitle, note: note)
            self.noNotesLabel.isHidden = true
            self.table.isHidden = false
            self.store.save()
            self.table.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Table functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = store.notes.count
        
        if count == 0 {
            table.isHidden = true
            noNotesLabel.isHidden = false
        } else {
            table.isHidden = false
            noNotesLabel.isHidden = true
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = store.notes[indexPath.row].title
        cell.detailTextLabel?.text = store.notes[indexPath.row].note
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = store.notes[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.noteTitle = model.title
        vc.note = model.note
        vc.editNote = { noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.store.editNote(title: noteTitle, note: note, index: indexPath.row)
            self.store.save()
            self.table.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func loadData(){
        let titles = UserDefaults.standard.stringArray(forKey: "titles") ?? []
        let contents = UserDefaults.standard.stringArray(forKey: "contents") ?? []

        let zipped = zip(titles, contents)

        zipped.forEach { store.addNote(title: $0.0, note: $0.1) }

        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            store.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            store.save()
        }
    }
}
