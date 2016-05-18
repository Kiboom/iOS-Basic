//: Playground - noun: a place where people can play

import UIKit

func makePascalTriangle(numOfRows:Int, prevTriangle:[[Int]]) -> ([[Int]]) {
    if(prevTriangle.count == numOfRows) {
        return prevTriangle;
    }
    let lastRow = prevTriangle[prevTriangle.count-1]
    let currentTriangle = prevTriangle + [pascalCalculate(lastRow)]
    return makePascalTriangle(numOfRows, prevTriangle: currentTriangle)
}

func pascalCalculate(prevRow:[Int]) -> ([Int]) {
    let prevRowWith0 = zip([0]+prevRow, prevRow+[0])
    return prevRowWith0.map({
        (elements: (Int, Int)) -> Int in
        elements.0 + elements.1
    })
}

makePascalTriangle(4, prevTriangle: [[1]])