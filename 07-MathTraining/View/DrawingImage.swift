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
    /*override func draw(_ rect: CGRect) {
        
        // Drawing code
        
    }
    */
    
    func draw(from start: CGPoint, to end: CGPoint) {
        
        let rendered = UIGraphicsImageRenderer(size: self.bounds.size)
        
        self.image = rendered.image(actions: { ctx in
            self.image?.draw(in: self.bounds )
            
            // Definir los parametrso de dibujo
            UIColor.darkGray.setStroke()
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.setLineWidth(9)
            
            // Pintar la linea
            ctx.cgContext.move(to: start)
            ctx.cgContext.addLine(to: end)
            ctx.cgContext.strokePath()
            
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        super.touchesBegan(touches, with: event)
        self.currentTouchPosition = touches.first?.location(in: self)
        
        NSObject.cancelPreviousPerformRequests(withTarget: self )
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let newTouchPoint = touches.first?.location(in: self) else {
            return
        }
        
        guard let previousTouchPoint = self.currentTouchPosition else {
            return
        }
        
        draw(from: previousTouchPoint, to: newTouchPoint)
        self.currentTouchPosition = newTouchPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    
        self.currentTouchPosition = nil
        perform(#selector(numberDrawOnScreen), with: nil, afterDelay: 0.5 )
        
    }
    
    @objc func numberDrawOnScreen() {
        
        guard let image = self.image else {
            return
        }
        
        let drawRect = CGRect(x: 0, y: 0, width: 28, height: 28)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let rendered = UIGraphicsImageRenderer(bounds: drawRect, format: format)
        
        let imageWithBackground = rendered.image { (ctx ) in
            
            UIColor.white.setFill()
            ctx.fill(bounds)
            image.draw(in: drawRect)
        }
        
        // Convierte una imagen CG a CI
        let ciImage = CIImage(cgImage: imageWithBackground.cgImage!)
        
        
        // Hacemos una inversión de color para convertir fondo balnco en negro
        if let filter = CIFilter(name: "CIColorInvert") {
            // Define CIImage como imagen a ser filtrada
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
            // Contexto para llevar a cabo el filtro de la conversión
            let context = CIContext(options: nil)
            
            
            if let outputImage = filter.outputImage {
                // Intentamos hacer la creación a CGImage
                if let imageRef = context.createCGImage(outputImage, from: ciImage.extent ){
                    // Convertimos 'eso' a un objeto UIImage en el que podemos procesar los resultados
                    let resulImage = UIImage(cgImage: imageRef)
                    
                    self.delegate?.numberDrawn( resulImage )
                }
            }
            
            
                
        }
        
    }

}
