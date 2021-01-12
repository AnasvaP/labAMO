//
//  laba4MainVC.swift
//  AMO
//
//  Created by Anasva on 06.04.2020.
//  Copyright © 2020 Anasva. All rights reserved.
//

import UIKit

class laba4MainVC: UIViewController {

    @IBOutlet var solution1TF: UITextField!
    @IBOutlet var Solution2TF: UITextField!
    @IBOutlet var Solution3TF: UITextField!
    @IBOutlet var epsilonTF: UITextField!
    @IBOutlet var labelForElse: UILabel!
    let epsilon: Double = 0.0001
    
    override func viewDidLoad() {
        super.viewDidLoad()
        epsilonTF.text = epsilon.description
    }
    

    func solveEq(a:Double, b:Double) -> Double{
        //var a : Double = 0, b: Double = 1.1
        //var a : Double = 1.1, b: Double = 2
        //var a : Double = 3.2, b: Double = 4
       // let epsilon: Double = 0.0001
        var arrForXi: [Double] = []


        // функція розв'язання рівняння при певному підставленому значенню
        func function(x: Double) -> Double{
            let equation = pow(x,3) - 6*pow(x,2) + 9*x - 3
            return equation
        }

        var functA = (function(x: a))
        var functB = (function(x: b))


        // визначаю рухомий кінець хорди
        func isEndsOfTheChordMoving (a: Double, b: Double ) -> Double {
            let secondPohidna  = 6*a - 12
            if functA * secondPohidna > 0 {
                print("Рухомий кінець a = \(a)")
                return a
            }
            if functB * secondPohidna > 0{
                print("Рухомий кінець b =  \(b)")
                return b
            }
            else {
                print ("Рухомий кінець визначити не вдалось ")
                exit(0)
            }
        }



        func findXIIfEndIsA(x: Double, b:Double) -> Double {
            let xi = x - (function(x: x) * (b - x))/(functB - function(x: x))
            return xi
        }



        func findXIIfEndIsB(x: Double, a:Double) -> Double {
            let xi = x - (function(x: x) * (x - a))/(function(x: x) - functA)
            return xi
        }

        let endOfChord = isEndsOfTheChordMoving(a: a, b: b)

        //main part
        if functA * functB < 0{
            arrForXi.removeAll()
            var k = 1
            
            if endOfChord == a{
                        arrForXi.append(functB)
                repeat {
                           let next = findXIIfEndIsA(x: arrForXi[k-1], b: b)
                           arrForXi.append(findXIIfEndIsA(x: next, b: b))
                           k += 1
                       }
                        while Double(abs(arrForXi[k-1] - arrForXi[k-2])) > epsilon
                    
            }else if endOfChord == b{
                               arrForXi.append(functA)
                repeat {
                                let next = findXIIfEndIsB(x: arrForXi[k-1], a: a)
                                arrForXi.append(findXIIfEndIsB(x: next, a: a))
                                k += 1
                        }
                        while Double(abs(arrForXi[k-1] - arrForXi[k-2])) > epsilon
            }

            print("Усі тимчасові корені: \(arrForXi)")
            print("Кількість ітерацій: \(k)")
            print("Значення х = \(String(describing: arrForXi.last))")
            
            
        } else {
            print("виберіть інший відрізок (кінці відрізка)")
                    exit(0)
        }

        //очінка погрішності

        func firstPohidna(x: Double) -> Double{
            let pohidna = 3 * pow(x,2) - 12*x + 9
            return pohidna
        }

        func errorEstimation( xArr: [Double]) {

            var m1: Double = 0 ,M1: Double = 0
            if endOfChord == a{
             M1 = abs(firstPohidna(x: a))
             m1 = abs(firstPohidna(x: b))
            }
            else if endOfChord == b{
                 M1 = abs(firstPohidna(x: b))
                 m1 = abs(firstPohidna(x: a))
            }
                if  abs(firstPohidna(x: xArr[xArr.count-2])) >= m1 {
                        let estimation = abs(function(x: xArr[xArr.count-2]))/m1
                        print ("Оцінка похибки :\(estimation)")
                        
                        let absoluteError = (M1 - m1)*(abs(xArr[xArr.count-2] - xArr[xArr.count-3]))/m1
                        print("Абсолютна погрішність: \(absoluteError)")
                }
                else{
                    print("error1")
                }
        }

        errorEstimation(xArr: arrForXi)
        return arrForXi.last!
    }


    
    @IBAction func solve1Button(_ sender: UIButton) {
        let x1 = solveEq(a: 0.1, b: 0.9)
        solution1TF.text = x1.description
     }

    @IBAction func solve2Button(_ sender: UIButton) {
        let x2 = solveEq(a: 1.1, b: 2)
        Solution2TF.text = x2.description
    }
    

    @IBAction func solve3Button(_ sender: UIButton) {
        let x3 = solveEq(a: 3.2, b: 4)
        Solution3TF.text = x3.description
    }

    
    
    
    
}

