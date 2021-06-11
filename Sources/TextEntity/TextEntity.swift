//
//  RealityKit-Text.swift
//  RealityKit-Text
//
//  Created by Grant Jarvis on 8/24/20.
//  Copyright © 2020 Grant Jarvis. All rights reserved.
//


import RealityKit
import UIKit

@available(iOS 13.0, *)
open class TextEntity : Entity {
    
    public var text: String = "Hello World" {
        didSet { if oldValue != text { makeText()}}}
    public var color: UIColor = .blue {
        didSet { if oldValue != color { makeText()}}}
    public var size: CGFloat = 0.1 {
        didSet { if oldValue != size { makeText()}}}
    public var isMetallic: Bool = true {
        didSet { if oldValue != isMetallic { makeText()}}}
    public var fontName: String = "Helvetica" {
        didSet { if oldValue != fontName { makeText()}}}
    public var extrusionDepth: Float = 0.01 {
        didSet { if oldValue != extrusionDepth { makeText()}}}
    public var alignment: alignment = .center {
        didSet { if oldValue != self.alignment { makeText()}}}
    
    
    
    ///The child of the TextEntity, which has the visible mesh and material.
    ///
    ///The textModel has its position compensated relative to its parent (the TextEntity) to make it have the proper alignment.
    private var textModel : ModelEntity!
    
    public enum alignment {
        case left, center, right
    }

    
    required public init() {
        super.init()
        makeText()
    }
    
    public init(text: String = "Hello World", color: UIColor = .blue) {
        super.init()
        self.text = text
        self.color = color
        makeText(text: text, color: color)
    }
    
    public init(text: String = "Hello World", color: UIColor = .blue, size: CGFloat = 0.1, isMetallic: Bool = true, fontName: String = "Helvetica", extrusionDepth: Float = 0.01, alignment: alignment = .center) {
        super.init()
        self.text = text
        self.color = color
        self.size = size
        self.isMetallic = isMetallic
        self.fontName = fontName
        self.extrusionDepth = extrusionDepth
        self.alignment = alignment
        makeText(text: text, color: color, size: size, isMetallic: isMetallic, fontName: fontName, extrusionDepth: extrusionDepth, alignment: alignment)
    }
    

    

    //Using nil default values allows us to not call makeText() for every variable's didSet{} property observer upon initialization.
    private func makeText(text: String? = nil,
                          color: UIColor? = nil,
                          size: CGFloat? = nil,
                          isMetallic: Bool? = nil,
                          fontName: String? = nil,
                          extrusionDepth: Float? = nil,
                          alignment: alignment? = nil) {
        
        let textLocal = text ?? self.text
        let colorLocal = color ?? self.color
        let sizeLocal = size ?? self.size
        let isMetalliclocal = isMetallic ?? self.isMetallic
        let fontNameLocal = fontName ?? self.fontName
        let extrustionDepthLocal = extrusionDepth ?? self.extrusionDepth
        let alignmentLocal = alignment ?? self.alignment
        
        let textMesh = MeshResource.generateText(textLocal,
                                          extrusionDepth: extrustionDepthLocal,
                                          font: UIFont.init(name: fontNameLocal, size: sizeLocal)!,
                                          containerFrame: CGRect.zero,
                                          alignment: .natural,
                                          lineBreakMode: .byTruncatingTail)
        
        let textMaterial = SimpleMaterial.init(color: colorLocal, isMetallic: isMetalliclocal)
        textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])
        textModel.name = "textModel"
        
        //removeAll(where:) is not available.
        for child in self.children { if child.name == "textModel" { child.removeFromParent() } }
        self.addChild(textModel)
        
        //Move it down and to the left relative to its parent entity by the magnitude of the compensation.
        textModel.position = getCompensation(alignment: alignmentLocal)
    }

    
    
    ///Gets half of the width, height and length of the bounding box,
    ///because the origin-point of the text is originally in the bottom-left corner of the bounding box.
    private func getCompensation(alignment: alignment = .center) -> SIMD3<Float>{

        let bounds = textModel.model?.mesh.bounds
        let boxCenter = bounds!.center
        let boxMin = bounds!.min
        var compensation = boxMin - boxCenter
          //was already in the center on the Z-Axis.
        switch alignment {
            case .center:
                compensation *= [1,1,0]
            case .left:
                compensation *= [2,1,0]
            case .right:
                compensation *= [0,1,0]
        }
        return compensation
    }
    
    
    
}

