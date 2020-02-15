//
//  ViewController.swift
//  DragAndDrop_TableToView
//
//  Created by TATSUYA YAMAGUCHI on 2020/02/09.
//  Copyright © 2020 TATSUYA YAMAGUCHI. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource {

    @objc dynamic let imageNames: [String] = ["Pikachu",  "Eevee", "Psyduck"]


    //MARK: - NSTableViewDataSource methods

    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        
        return imageNames[row] as NSString
    }
}
