//
//  mainLaba2VC.swift
//  AMO
//
//  Created by Anasva on 29.02.2020.
//  Copyright © 2020 Anasva. All rights reserved.
//

import UIKit

class mainLaba2VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var timeNanosecond = 0
    var timeSeconds = 0

    
    func sortArray( myArray : [Int]) -> [Int]{
        
        //час виконання алгоритму
        let date = Date()
        let calendar = Calendar.current
        timeNanosecond = calendar.component(.nanosecond , from: date)
        timeSeconds = calendar.component(.second, from: date)
        
        
        var array : [Int] = myArray
        let size : Int = array.count
        for i in 0..<size{
            let pass = (size - 1 ) - i
           for j in 0..<pass{
               if array[j]>array[j+1]{
                let t = array[j]
               array[j]=array[j+1];
               array[j+1]=t
           }
        }
        }
       return array
    }
    
    func randomArray() -> [Int]{
        
        let size : Int = Int(textFieldForSizeVar.text!) ?? 0
        var randomArray : [Int] = []
        
        if textFieldForSizeVar.hasText == true{
            
            for _ in 0..<size{
            randomArray.append(Int.random(in: 0...100))
                }
        }
        else{
            labeIftextFieldIsEmpty.textColor = UIColor.red
        }
        return randomArray
    }
    
    
    @IBOutlet var labeIftextFieldIsEmpty: UILabel!
    @IBOutlet var textFieldForSizeVar: UITextField!
    @IBOutlet var textFieldForRandomArray: UITextField!
    @IBOutlet var textFieldForSortedArray: UITextField!
    @IBOutlet var textFieldForTimeNanoseconds: UITextField!
    
    @IBAction func randomArrayButton(_ sender: UIButton) {
        
        let array : [Int] = randomArray()
        textFieldForRandomArray.text = array.debugDescription
        textFieldForSortedArray.text = sortArray(myArray: array).debugDescription
        
        //час виконання алгоритму
        let date = Date()
        let calendar = Calendar.current
        var nanosecond1 = calendar.component(.nanosecond , from: date)
        if nanosecond1 < timeNanosecond {
            nanosecond1 = nanosecond1 + 1000000000
        }
        let tNanosecond = nanosecond1 - timeNanosecond
        textFieldForTimeNanoseconds.text = tNanosecond.description
    }
    
    
    @IBAction func FileButton(_ sender: UIButton) {
        
         //читаю з файл
                let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        //print(path as Any)

                do{
                    let fileURLDATA = path!.appendingPathComponent("AMO2labDATA.txt")
                    let textContent = try String(contentsOf: fileURLDATA, encoding: .utf8)
                    
                    let fileURLRESULT = path!.appendingPathComponent("AMO2labRESULT.txt")

                    let textContentArray = textContent.components(separatedBy: .newlines)

                    
                    var arr : [Int] = []
                    for j in 0..<textContentArray.count{
                        arr.append(Int(textContentArray[j])!)
                    }
                    
                    let sortArr : [Int] = sortArray(myArray: arr)

                    textFieldForSortedArray.text = sortArr.description
                    textFieldForRandomArray.text = textContentArray.debugDescription

                    //записую у файл
                    try String(sortArr.description).write(to: fileURLRESULT, atomically: false, encoding: .utf8)

                } catch {
                    print(error)

                }
        //час виконання алгоритму
        let date = Date()
        let calendar = Calendar.current
        var nanosecond1 = calendar.component(.nanosecond , from: date)
        if nanosecond1 < timeNanosecond {
            nanosecond1 = nanosecond1 + 1000000000
        }
        let tNanosecond = nanosecond1 - timeNanosecond
        textFieldForTimeNanoseconds.text = tNanosecond.description
    
    }
    // звичайний тап , який ховає клавіатуру натиснувши будь-де на екрані
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        textFieldForSizeVar.resignFirstResponder()
    

    }

    
        
//        var array : [Int] = [5,7,9,2,0,5,7,8,9,3,4,6,7,8]
//        var swapped : Bool = false
//        var k : Int = array.count-1
//
//        while k>0{
//            swapped = false
//            var i : Int = k
//
//            while i > array.count - 1 - k{
//                if array[i]<array[i-1]{
//                    let t : Int  = array[i]
//                    array[i]=array[i-1];
//                    array[i-1]=t
//                    swapped = true
//                }
//                i = i-1
//            }
//
//            var j : Int = array.count - k
//
//            while j < k {
//                if array[i]>array[i+1]{
//                    let t : Int  = array[i]
//                array[i]=array[i+1];
//                array[i+1]=t
//                    swapped = true
//                }
//                j = j+1
//            }
//            k = k-1
//            print (k)
//            if !swapped{
//                break
//            }
//        }
//        print(array)
//
//
//
//
//
//          var Array : [Int] = [2,7,4,9,8,3,8,9,0,6,5,0,4]
//          var  leftBound: Int = 1;
//          var  rightBound : Int = Array.count-1;
//          var i : Int = rightBound
//          var f : Int = 0
//          var t: Int = Array.count - 1
//
//        repeat{
//            while i > 0 {
//
//                if Array[i-1]>Array[i]{
//                    t = Array[i]
//                    Array[i]=Array[i-1];
//                    Array[i-1]=t
//                     f = i
//                }
//                    i -=  1
//            }
//             leftBound = leftBound + 1
//            for i in Array {
//                           if Array[i]>Array[i+1]{
//                           t = Array[i]
//                           Array[i]=Array[i+1];
//                           Array[i+1]=t
//                            f = i
//                             }
//
//                       }
//            rightBound = rightBound - 1
//                }
//            while (leftBound < rightBound)
//
//        print(Array)
    
}
