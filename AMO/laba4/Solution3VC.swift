//
//  Solution3VC.swift
//  AMO
//
//  Created by Anasva on 07.04.2020.
//  Copyright © 2020 Anasva. All rights reserved.
//

import UIKit

class Solution3VC: UIViewController {

     
       @IBOutlet var solutionTF: UITextField!
           @IBOutlet var timeSolution1TV: UITextView!
           @IBOutlet var numberOfIterationTF: UITextField!
           @IBOutlet var aTF: UITextField!
           @IBOutlet var bTF: UITextField!
           @IBOutlet var estimationTF: UITextField!
           @IBOutlet var absolErrorTF: UITextField!
           
    let a:Double = 3.2, b:Double = 4
           override func viewDidLoad() {
               super.viewDidLoad()
               solutionTF.text = (solveEq(a: a, b: b)[0] as AnyObject).description
               timeSolution1TV.text = ((solveEq(a: a, b: b)[1]) as AnyObject).description
               numberOfIterationTF.text = (solveEq(a: a, b: b)[2] as AnyObject).description
               aTF.text = a.description
               bTF.text = b.description
               
               estimationTF.text = ((solveEq(a: a, b: b)[3]) as AnyObject).description
               absolErrorTF.text = ((solveEq(a: a, b: b)[4]) as AnyObject).description
               
           }
           
           
           func solveEq(a:Double, b:Double) -> [Any]{
               //var a : Double = 0, b: Double = 1.1
               //var a : Double = 1.1, b: Double = 2
               //var a : Double = 3.2, b: Double = 4
               let epsilon: Double = 0.0001
               var arrForXi: [Double] = []
               var k = 1


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
                   k = 1
                   
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
                   
                   
               } else {print("виберіть інший відрізок (кінці відрізка)")}

               //очінка погрішності

               func firstPohidna(x: Double) -> Double{
                   let pohidna = 3 * pow(x,2) - 12*x + 9
                   return pohidna
               }

               func errorEstimation( xArr: [Double]) -> (firstV: Double, lastV: Double) {

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
                           return (estimation,absoluteError)
                       }
                       else{
                           print("error1")
                           exit(0)
                       }
               }

               let estimation = errorEstimation(xArr: arrForXi).firstV
               let absError = errorEstimation(xArr: arrForXi).lastV
               return [arrForXi.last!,arrForXi,k,estimation,absError]
           }

}
