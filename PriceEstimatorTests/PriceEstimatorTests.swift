//
//  PriceEstimatorTests.swift
//  PriceEstimatorTests
//
//  Created by Can ATAC on 13/05/2015.
//  Copyright (c) 2015 Can ATAC. All rights reserved.
//

import UIKit
import XCTest
import PriceEstimator

class PriceEstimatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetResults() {
        // This is an example of a functional test case.
        let priceEstimator = Estimator()
        var criteria:[String:String]=["productName":"COCO"]
        let results = priceEstimator.getResults(criteria)
        println(results)
        println("Median Price : \(priceEstimator.getMedianPrice())")
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
