//
//  DiagramsLaba2VC.swift
//  AMO
//
//  Created by Anasva on 09.03.2020.
//  Copyright © 2020 Anasva. All rights reserved.
//

import UIKit

class DiagramsLaba2VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   @IBAction func sizeForDiagram1(_ sender: UIPinchGestureRecognizer) {
        
            if let view = sender.view{
                view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
                sender.scale=1
            }
        }
        
        @IBAction func PanGestureRecDiagram1(_ sender: UIPanGestureRecognizer) {
            
            let translation = sender.translation(in: self.view)
            if let view = sender.view{
                view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
                sender.setTranslation(CGPoint.zero, in: self.view)
            
        }
    }
}
