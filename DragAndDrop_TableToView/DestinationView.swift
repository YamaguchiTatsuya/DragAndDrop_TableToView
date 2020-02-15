//
//  DestinationView.swift
//  DragAndDrop_TableToView
//
//  Created by TATSUYA YAMAGUCHI on 2020/02/09.
//  Copyright © 2020 TATSUYA YAMAGUCHI. All rights reserved.
//

import Cocoa

class DestinationView: NSView {

    required init?(coder: NSCoder) {
        
            super.init(coder: coder)
        
            setup()
        }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let color = NSColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        color.setFill()
        dirtyRect.fill()
    }
    
    private func setup() {
    
        registerForDraggedTypes([ .string ])
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        return .copy
    }
    
    override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {

        let pasteBoard = draggingInfo.draggingPasteboard
        
        let point = convert(draggingInfo.draggingLocation, from: nil)

        
        if let strings = pasteBoard.readObjects(forClasses: [NSString.self], options: nil) as? [String] {
            processImages(strings, center: point)
        }
        return true
    }
    
    //MARK: - draw dropped images
    
    private func processImages(_ fileNames: [String], center: NSPoint) {
        
        for (index, fileName) in fileNames.enumerated() {

            if let image = NSImage(named: fileName) {
                
                let newCenter = NSPoint(x: center.x+CGFloat(200*index),
                                        y: center.y)
                
                processImage(image, center:newCenter)
            }
        }
    }
    
    private func processImage(_ image: NSImage, center: NSPoint) {

        let constrainedSize = image.aspectFitSizeForMaxDimension(150.0)
        
        let imageView = NSImageView(image: image)
        imageView.frame = NSRect(x: center.x - constrainedSize.width/2, y: center.y - constrainedSize.height/2, width: constrainedSize.width, height: constrainedSize.height)
        self.addSubview(imageView)
    }
}

//MARK: - extension

extension NSImage {
    
    func aspectFitSizeForMaxDimension(_ maxDimension: CGFloat) -> NSSize {
        
        var width =  size.width
        var height = size.height
        if size.width > maxDimension || size.height > maxDimension {
            let aspectRatio = size.width/size.height
            width = aspectRatio > 0 ? maxDimension : maxDimension*aspectRatio
            height = aspectRatio < 0 ? maxDimension : maxDimension/aspectRatio
        }
        
        return NSSize(width: width, height: height)
    }
}
