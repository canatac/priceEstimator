//
//  Estimator.swift
//  PriceEstimator
//
//  Created by Can ATAC on 13/05/2015.
//  Copyright (c) 2015 Can ATAC. All rights reserved.
//

import Foundation

public class Estimator {
    var medianPrice = "0"
    var productNameInCriteria = ""
    
    func getResults(criteria : [String:String]) ->[String:String]
    {
        productNameInCriteria = criteria["productName"]!

        var answers = getAnswers(criteria)
        medianPrice = calculateMedianPrice(answers)
        
        
        //var results:[String:String?]=["productName":productName,"medianPrice":medianPrice]

        
        return answers
    }
    func getMedianPrice()->String{
        return medianPrice
    }
    private func getAnswers(criteria : [String:String]) -> [String:String]
    {
        var answers = getProviderAnswers(criteria)
        var newList:[String]
        
        return answers
    }
    
    private func calculateMedianPrice(answers : [String:String]) -> String
    {
        return "10"
    }
    
    private func getProviderAnswers(criteria : [String:String]) -> [String:String]
    {
        var answers:[String:String] = ["productName":"product1","price":"11"]
        var processedDico:[String:String] = processAnswers(answers)
        
        return processedDico
    }
    
    private func processAnswers(providerResults : [String:String]) -> [String:String]
    {
        var processedAnswers:[String:String] = [:]
        for (productName,price) in providerResults{
            if(isPertinent(productName)) {processedAnswers[productName]=price}
        }
        return processedAnswers
    }
    
    private func isPertinent(productName : String) -> Bool
    {
        return couldBeEquals(productName, productName: productNameInCriteria, percentageOfChar: 80)
    }
    
    private func getDepreciationRate(date: String, productName : String)-> Float
    {
        return 0.0
    }
    
    private func couldBeEquals(productNameReturned : String, productName: String, percentageOfChar: Int) -> Bool
    {
        var n = 0
        var nbEquality = 0
        var index1   = productName.startIndex;
        var index2   = productNameReturned.startIndex;

        let nbCharToCompare = count(productName)*percentageOfChar/100
        
        do
        {
            if productName[index1] == productNameReturned[index2]
            {
                nbEquality++
            }
            index1.successor()
            index2.successor()
            n++
        }
        while n < nbCharToCompare

        if nbEquality == nbCharToCompare
        {
            return getSimilarity(productName, stringToCompare: productNameReturned)
        }else
        {
            return false
        }
        
    }
    
    private func computeDistance(refString : String, stringToCompare: String)-> Double
    {
        var n = count(refString)
        var m = count(stringToCompare)
        var o = n + 1
        var p = m + 1
        
        typealias mytuple = (num1: Int, num2: Int)
        var distance: [mytuple] = [mytuple]()
        
        //var distance = [Int:Int]() // matrix
        //var answers:[String:String] = ["productName":"product1","price":"11"]
        
        var cost=0;
        
        if(n == 0) {return Double(m)}
        if(m == 0) {return Double(n)}
        //init1
        for var i = 0; i <= n; ++i{
            distance[i].num1=i
            distance[i].num2=0
        }
        
        for var j = 0; j <= m; ++j{
            distance[j].num1=0
            distance[j].num2=j
        }

        
        //find min distance
        
        for(var i=1; i <= n; i++)
        {
            for(var j=1; j <= m;j++)
            {
                /*
                cost=(stringToCompare.Substring(j - 1, 1) ==
                    refString.Substring(i - 1, 1) ? 0 : 1);
                distance[i,j]=Min3(distance[i - 1, j] + 1,
                    distance[i, j - 1] + 1,
                    distance[i - 1, j - 1] + cost);
*/
            }
        }
        return Double(distance[n].num1);
    }
    
    private func getSimilarity(refString : String, stringToCompare: String)->Bool
    {
        var dis = computeDistance(refString, stringToCompare: stringToCompare)
        
        var maxLen = count(refString)
        
        if maxLen < count(stringToCompare)
        {
          maxLen = count(stringToCompare)
        }
        if maxLen == 0
        {
            return true
        }
        else
        {
            if (1.0 - (dis/Double(maxLen))) > 0.8
            {
                return true
            }
            else
            {
                return false
            }
        }
    }
}
