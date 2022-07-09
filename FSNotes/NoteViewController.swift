//
//  NoteViewController.swift
//  FSNotes
//
//  Created by Oleksandr Hlushchenko on 25.06.2022.
//  Copyright © 2022 Oleksandr Hlushchenko. All rights reserved.
//

import Foundation
import AppKit

class NoteViewController: EditorViewController, NSWindowDelegate {
    
    @IBOutlet weak var emptyEditAreaImage: NSImageView!
    @IBOutlet weak var shareButton: NSButton!
    @IBOutlet weak var previewButton: NSButton!
    @IBOutlet weak var lockUnlockButton: NSButton!
    
    @IBOutlet weak var titleLabel: TitleTextField!
    @IBOutlet weak var editor: EditTextView!
    @IBOutlet weak var editorScrollView: EditorScrollView!
    @IBOutlet weak var titleBarView: TitleBarView!
    
    public func initWindow() {
        view.window?.title = "New note"
        view.window?.titleVisibility = .hidden
        view.window?.titlebarAppearsTransparent = true
        view.window?.backgroundColor = .white
        view.window?.delegate = self
        
        editor.initTextStorage()
        editor.editorViewController = self
        editor.configure()
        
        vcEditor = editor
        vcTitleLabel = titleLabel
        vcEmptyEditAreaImage = emptyEditAreaImage
        vcEditorScrollView = editorScrollView
        
        super.initView()
    }
    
    func windowDidResize(_ notification: Notification) {
        editor.updateTextContainerInset()
        
        super.viewDidResize()
    }
    
    func windowWillReturnUndoManager(_ window: NSWindow) -> UndoManager? {
        if let fr = window.firstResponder,
            fr.isKind(of: EditTextView.self),
            editor.isEditable {
            return editor.editorViewController?.editorUndoManager
        }
        
        return nil
    }
}