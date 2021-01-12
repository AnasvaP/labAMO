//
//  laba5MainVC.swift
//  AMO
//
//  Created by Anasva on 09.04.2020.
//  Copyright © 2020 Anasva. All rights reserved.
//

import UIKit

class laba5MainVC: UIViewController {

    @IBOutlet var epsilonTF: UITextField!
    @IBOutlet var tt: UITextField!
    @IBOutlet var astimationTF: UITextField!
    @IBOutlet var numberOfIterationTF: UITextField!
    @IBOutlet var solve3TF: UITextField!
    @IBOutlet var solve2TF: UITextField!
    @IBOutlet var solve1TF: UITextField!
    
    @IBOutlet var k00: UITextField!
    @IBOutlet var k01: UITextField!
    @IBOutlet var k02: UITextField!
    @IBOutlet var k03: UITextField!
    
    @IBOutlet var k10: UITextField!
    @IBOutlet var k11: UITextField!
    @IBOutlet var k12: UITextField!
    @IBOutlet var k13: UITextField!
    
    @IBOutlet var k20: UITextField!
    @IBOutlet var k21: UITextField!
    @IBOutlet var k22: UITextField!
    @IBOutlet var k23: UITextField!
    
    let arrA: [[Double]] = [[8,1,1],[1,5,-1],[1,-1,5]], /*arrA: [[Double]] = [[3,1,1],[4,6,-1],[1,-10,5]],*/ arrB: [Double] = [26,7,7] , epsilon = 0.001
      //let alfaArr: [[Double]] = [[0,-1/8,-1/8],[-1/5,0,1/5],[-1/5,1/5,0]], bettaArr: [Double] = [26/8,7/5,7/5], epsilon = 0.001
      var sum1 = 0.0, sum2 = 0.0 ,sum3 = 0.0, sum = 0.0 , xArr = Array<Array<Double>>()
      // x=3 x=1 x=1

    var alfaArr: [[Double]] = [[],[],[]] , bettaArr: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alfaArr = systemTransformationForAlfaArray(arrAlfa: arrA, arrBetta: arrB).0
        bettaArr = systemTransformationForAlfaArray(arrAlfa: arrA, arrBetta: arrB).1
        //testForConvergence(alfaArray: alfaArr)
        if testForConvergence(alfaArray: alfaArr).1 == true {
            tt.text = "Умови збіжності виконуються!"
            solve1TF.text = methodKob(alfaArray: alfaArr).0.description
            solve2TF.text = methodKob(alfaArray: alfaArr).1.description
            solve3TF.text = methodKob(alfaArray: alfaArr).2.description
            numberOfIterationTF.text = methodKob(alfaArray: alfaArr).3.description
            astimationTF.text = estimation(convergence: testForConvergence(alfaArray: alfaArr).0, bettaArray: bettaArr, k: methodKob(alfaArray: alfaArr).3).description
            epsilonTF.text = epsilon.description
            
            k00.text = arrA[0][0].description
            k01.text = arrA[0][1].description
            k02.text = arrA[0][2].description
            k03.text = arrB[0].description
            
            k10.text = arrA[1][0].description
            k11.text = arrA[1][1].description
            k12.text = arrA[1][2].description
            k13.text = arrB[1].description
            
            k20.text = arrA[2][0].description
            k21.text = arrA[2][1].description
            k22.text = arrA[2][2].description
            k23.text = arrB[2].description
            
        }
        else {
            tt.text = "Умови збіжності не виконуються!"
        }
    }

    func systemTransformationForAlfaArray (arrAlfa: [[Double]], arrBetta: [Double] ) -> ([[Double]] , [Double]) {
        var transformedArrAlfa: [[Double]] = [[0,0,0],[0,0,0],[0,0,0]],
        transformedArrBetta: [Double] = [0,0,0]
        for i in 0...2{
            for j in 0...2{
                transformedArrAlfa[i][j] = -1 * (arrAlfa[i][j] / arrAlfa[i][i])
                transformedArrAlfa[i][i] = 0
            }
            transformedArrBetta[i] = arrBetta[i] / arrAlfa[i][i]
        }
        return (transformedArrAlfa, transformedArrBetta)
    }

    //перевіряємо умови збіжності
    func testForConvergence(alfaArray: [[Double]])-> (Double , Bool){
        var convergence1: Double = 0, convergence2: Double = 0 , convergence3: Double = 0,
         isConditionFulfilled: Bool = false
        
        for i in 0...2{
            sum1 += abs(alfaArray[0][i])
            sum2 += abs(alfaArray[1][i])
            sum3 += abs(alfaArray[2][i])
            convergence1 = max(sum1, sum2, sum3)
            sum1 = 0.0 ;sum2 = 0.0 ;sum3 = 0.0
            sum1 += abs(alfaArray[i][0])
            sum2 += abs(alfaArray[i][1])
            sum3 += abs(alfaArray[i][2])
            convergence2 = max(sum1, sum2, sum3)
            
            for j in 0...2{
                sum += pow(abs(alfaArray[i][j]),2)
                convergence3 = sqrt(sum)
            }
        }
        if convergence1 < 1 {
            isConditionFulfilled = true
            print("Перша умова збіжності виконується")
            return (convergence1 , isConditionFulfilled)
        }
         if convergence2 < 1{
            isConditionFulfilled = true
            print("Друга умова збіжності виконується")
             return (convergence2 , isConditionFulfilled)
        }
         if convergence3 < 1{
            isConditionFulfilled = true
            print("Третя умова збіжності виконується")
             return (convergence3 , isConditionFulfilled)
        }
    //     if alfaArray[0][0] > alfaArray[0][1] + alfaArray[0][2] &&
    //        alfaArray[1][1] > alfaArray[1][0] + alfaArray[1][2] &&
    //        alfaArray[2][2] > alfaArray[2][0] + alfaArray[2][1]{
    //        isConditionFulfilled = true
    //        print("П'ята умова збіжності виконується (наслідок)")
    //         return (convergence5 , isConditionFulfilled)
    //    }
         else{
            print("умови збіжності не виконуються!!!")
            return (0.0, isConditionFulfilled)
        }
    }
    
    func methodKob(alfaArray: [[Double]]) -> (Double , Double, Double,  Int) {
        xArr.append([0,0,0])
        var timeArr: [Double] = [0,0,0], k = 0
        
        repeat{
            for i in 0...2{
                timeArr[i] = (alfaArray[i][0] * xArr[k][0] + alfaArray[i][1] * xArr[k][1] + alfaArray[i][2] * xArr[k][2]) + bettaArr[i]
                }
                xArr.append(timeArr)
                k += 1
            } while  (Double(abs(xArr[k][0] - xArr[k-1][0])) > epsilon || Double(abs(xArr[k][1] - xArr[k-1][1])) > epsilon || Double(abs(xArr[k][2] - xArr[k-1][2])) > epsilon)
        
        //print("x1 = \(xArr[k][0]),\nx2 = \(xArr[k][1]),\nx3 = \(xArr[k][2])")
        return (xArr[k][0], xArr[k][1], xArr[k][2],  k)
    }
    //print(methodKob(alfaArray: alfaArr))

    func estimation(convergence: Double , bettaArray: [Double], k: Int) -> Double{
        
        var estimation = 0.0, converBetta: Double = 0
        converBetta = max(abs(bettaArray[0]), abs(bettaArray[1]), abs(bettaArray[2]))
        estimation = (pow(convergence, Double(k+1)) * converBetta) / (1 - convergence)
        
        return estimation
    }

    //print(estimation(convergence: testForConvergence(alfaArray: alfaArr).0, bettaArray: bettaArr, k: methodKob(alfaArray: alfaArr).3))

    

}
