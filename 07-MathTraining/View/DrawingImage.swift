//
//  DrawingImage.swift
//  07-MathTraining
//
//  Created by Jair Benítez on 31/12/18.
//  Copyright © 2018 Jair Benítez. All rights reserved.
//

import UIKit

class DrawingImage: UIImageView {

    weak var delegate : ViewController?
    var currentTouchPosition : CGPoint?
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // Drawing code
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    @objc func numberDrawOnScreen() {
        <#function body#>
    }

}
