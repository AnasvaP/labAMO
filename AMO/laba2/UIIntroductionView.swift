//
//  UIIntroductionView.swift
//  AMO
//
//  Created by Anasva on 09.03.2020.
//  Copyright © 2020 Anasva. All rights reserved.
//

import UIKit

@IBDesignable

class UIIntroductionView: UIView {
    

    override func draw(_ rect: CGRect) {
        let pathRect = CGRect(x: 25, y: 25, width: rect.width - 50 , height: rect.height - 50 )
//        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 24)
//        let color = UIColor.blue
//        color.setStroke()
//        path.stroke()
          drawLines(in: pathRect)
        
    }
    
    private func drawLines(in rect: CGRect){
        
        let path = UIBezierPath()
        let pathForLines = UIBezierPath()
        let pathForGraphics = UIBezierPath()
        
        let point1 = CGPoint(x: 30, y: 600)
        let point2 = CGPoint(x:350, y: 600 )
        let point3 = CGPoint(x: 30, y: 30 )

        path.move(to: point1)
        path.addLine(to: point2)

        path.move(to: point1)
        path.addLine(to: point3)

        // цикл для вертикальних ліній
        var ii : Int = 30
        while ii < 300{
            ii += 32
            let pointToStart = CGPoint(x: ii, y: 600)
            let pointToMove = CGPoint(x: ii, y: 30 )
            pathForLines.move(to: pointToStart)
            pathForLines.addLine(to: pointToMove)
        }
        //цикл для горизонтальних ліній
        var jj : Int = 600
               while jj > 60{
                jj -= 32
                   let pointToStart = CGPoint(x: 30, y: jj)
                   let pointToMove = CGPoint(x: 350, y: jj )
                   pathForLines.move(to: pointToStart)
                   pathForLines.addLine(to: pointToMove)
                
               }
        
        //для системи координат
        path.lineWidth = 1.5
        let color1 = UIColor.blue
        color1.setStroke()
        path.stroke()
        // для вертикальних і горизонтальних ліній
        pathForLines.lineWidth = 0.3
        let color2 = UIColor.blue
        color2.setStroke()
        pathForLines.stroke()
        
        
        
            let i : Int = 30
            let j : Int = 600
            let t : Int = 2800
            let p : Int = 32
            let pointToStart = CGPoint(x: i, y: j - p*t / 2818 )
            let pointToMove = CGPoint(x: 2*i, y: j - 2*p*2*t / 3489 )
            let pointToMove2 = CGPoint(x: 3*i, y: j - 3*p*3*t / 5302 )
            let pointToMove3 = CGPoint(x: 4*i, y: j - 4*p*4*t / 7570 )
            let pointToMove4 = CGPoint(x: 5*i, y: j - 5*p*5*t / 9875 )
            let pointToMove5 = CGPoint(x: 6*i, y: j - 6*p*6*t / 14091 )
            let pointToMove6 = CGPoint(x: 7*i, y: j - 7*p*7*t / 18387 )
            let pointToMove7 = CGPoint(x: 8*i, y: j - 8*p*8*t / 25738 )
            let pointToMove8 = CGPoint(x: 9*i, y: j - 9*p*9*t / 34608 )
            let pointToMove9 = CGPoint(x: 10*i, y: j - 10*p*10*t / 36467 )
            let pointToMove10 = CGPoint(x: 11*i, y: j - 11*p*11*t / 41742 )
            

            pathForGraphics.move(to: pointToStart)
            pathForGraphics.addLine(to: pointToMove)
        

            pathForGraphics.move(to: pointToMove)
            pathForGraphics.addLine(to: pointToMove2)
            

            pathForGraphics.move(to: pointToMove2)
            pathForGraphics.addLine(to: pointToMove3)
        
            
            pathForGraphics.move(to: pointToMove3)
            pathForGraphics.addLine(to: pointToMove4)
       
            
            pathForGraphics.move(to: pointToMove4)
            pathForGraphics.addLine(to: pointToMove5)
      
            
            pathForGraphics.move(to: pointToMove5)
            pathForGraphics.addLine(to: pointToMove6)
       
            
            pathForGraphics.move(to: pointToMove6)
        pathForGraphics.addLine(to: pointToMove8)
            pathForGraphics.addLine(to: pointToMove7)
            
            pathForGraphics.move(to: pointToMove7)

            pathForGraphics.move(to: pointToMove8)
            pathForGraphics.addLine(to: pointToMove9)
            
            pathForGraphics.move(to: pointToMove9)
            pathForGraphics.addLine(to: pointToMove10)
       
        
        pathForGraphics.lineWidth = 2
        let color3 = UIColor.red
        color3.setStroke()
        pathForGraphics.stroke()
        
    }

}
