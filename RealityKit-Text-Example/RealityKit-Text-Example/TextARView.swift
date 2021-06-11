//
//  TextARView.swift
//  TextPlacement-Example
//
//  Created by Grant Jarvis on 2/3/21.
//

import RealityKit
import ARKit
//import TextEntity

#if canImport(ARKit)
class TextARView: ARView, ARSessionDelegate {
    
    
    private var textEntityArray = [TextEntity]()
    
    private var enabledEntityIndex = 0
    
    private var timer = Timer()
    
    private var worldAnchor : AnchorEntity!
    

    required init(frame frameRect: CGRect) {
      super.init(frame: frameRect)
        self.session.delegate = self
        
        
        let sphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.02),
                                 materials: [SimpleMaterial(color: .red, isMetallic: false)])
        
        let transform = Transform(scale: [1,1,1],
                                  rotation: simd_quatf(),
                                  translation: [0,0,-1]).matrix
        worldAnchor = AnchorEntity(.world(transform: transform))
        self.scene.addAnchor(worldAnchor)
        
        worldAnchor.addChild(sphere)

        setUpText()
    }

    
    private func setUpText(){
        
        let text1 = TextEntity(text: "RealityKit ♥", color: .cyan, isMetallic: true, alignment: .center)
        //--//
        let text2 = TextEntity(text: "Left", color: .white, isMetallic: false, alignment: .left)
        //--//
        let text3 = TextEntity(text: "Center", color: .blue, isMetallic: false, alignment: .center)
        //--//
        let text4 = TextEntity(text: "Right", color: .red, isMetallic: false, alignment: .right)
        //--//
        textEntityArray = [text1, text2, text3, text4]
        
        textEntityArray.forEach { textEntity in
            worldAnchor.addChild(textEntity)
        }
        
        runTimer()
    }
    
    
    private func runTimer(){
        
        //Cycle through the text entities inside of textEntityArray, enabling one at a time.
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.textEntityArray.forEach { textEntityLocal in
                textEntityLocal.isEnabled = false
            }
            self.textEntityArray[self.enabledEntityIndex].isEnabled = true
            if self.enabledEntityIndex == (self.textEntityArray.count - 1) {
                self.enabledEntityIndex = 0
            } else{
                self.enabledEntityIndex += 1
            }
        }
    }
    

    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

#endif
