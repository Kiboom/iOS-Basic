/* 미니 실습 */

// 비트연산으로 이진수 구하기
func hammingWeight(num : Int) -> (String, Int) {
    var mask = 1<<31;
    var bits:String = ""
    var numberOf1s = 0;
    while(mask > 0) {
        if(num&mask==0) {
            bits += "0"
        } else {
            bits += "1"
            numberOf1s += 1;
        }
        mask = mask>>1
    }
    return (bits, numberOf1s)
}
var result = hammingWeight(11)
print(result)


// 나눗셈으로 이진수 구하기
func hammingWeight2(num : Int) -> (String, Int) {
    var numCopy = num;
    var bits:String = ""
    var numberOf1s = 0
    while(numCopy > 0) {
        if((num%2)==1) {
            numberOf1s += 1
        }
        bits = String(numCopy%2) + bits
        numCopy /= 2
    }
    return (bits, numberOf1s)
}
result = hammingWeight2(11)
print(result)





//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var view : UIView
view = UIView.init(frame: CGRectMake(0,0,100,100))
view.backgroundColor = UIColor.greenColor()
view.backgroundColor = UIColor.blackColor()

var total = 0
var numberArray = [Int]()     // Int가 들어간 Array를 표현하려면 var numberArray : [Int] = [Int]()
for number in 0...10 {  //...이 들어가면 10이 포함된 거. 만약 10보다 작은 걸 표현하려면 0..<10
    numberArray.append(number);
    total += number
}

numberArray
print("\(numberArray)")
















