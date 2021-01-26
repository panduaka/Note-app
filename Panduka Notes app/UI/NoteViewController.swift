//
//  NoteViewController.swift
//  Panduka Notes app
//
//  Created by Panduka Wedisinghe on 24/1/21.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    public var noteTitle: String = ""
    public var note: String = ""
    
    public var editNote: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = editButtonItem
        titleField.text = noteTitle
        self.titleField.delegate = self
        
        noteField.text = note
        self.noteField.layer.cornerRadius = 8;
        self.noteField.delegate = self
        self.noteField.layer.borderWidth = 1.0
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if isEditing {
            titleField.isEnabled = true
            noteField.isEditable = true
            noteField.isSelectable = true
        } else {
            titleField.isEnabled = false
            noteField.isEditable = false
            noteField.isSelectable = false
            saveData()
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.red.cgColor
      }

      func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.black.cgColor
      }
    
    private func saveData() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            editNote?(text, noteField.text)
        }
    }
}
