//
//  NoteEntryViewController.swift
//  Panduka Notes app
//
//  Created by Panduka Wedisinghe on 24/1/21.
//

import UIKit

class NoteEntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    public var completion: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.becomeFirstResponder()
        self.noteField.layer.cornerRadius = 8;
        self.noteField.delegate = self
        self.noteField.layer.borderWidth = 1.0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }

    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.red.cgColor
      }

      func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.black.cgColor
      }
}
