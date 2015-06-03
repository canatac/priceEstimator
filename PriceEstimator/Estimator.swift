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
    
    struct Repo {
        /*
        "ItemCount": "34",
        "PageCount": "7",
        "PageNumber": "0",
        "Products
*/
        let ItemCount: Int
        let PageCount: Int
        let PageNumber: Int
        let Product: String
    }
    
    func getResults(criteria : [String:String]) ->NSDictionary
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
    private func getAnswers(criteria : [String:String]) -> NSDictionary
    {
        var answers = getProviderAnswers(criteria)
        var newList:[String]
        
        return answers
    }
    
    private func calculateMedianPrice(answers : NSDictionary) -> String
    {
        return "10"
    }
    
    private func getProviderAnswers(criteria : [String:String]) -> NSDictionary
    {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://api.cdiscount.com/OpenApi/json/Search")!,cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 10)

        var response: NSURLResponse?
        var error: NSError?
        
        let jsonString = "{" +
        "\"ApiKey\": \"3a3d204e-5109-40ae-a924-b1995038dd29\"," +
        "\"SearchRequest\": {" +
            "\"Keyword\": \"sacoche\"," +
            "\"SortBy\": \"relevance\"," +
            "\"Pagination\": {" +
                "\"ItemsPerPage\": 5," +
                "\"PageNumber\": 0" +
            "}," +
            "\"Filters\": {" +
                "\"Price\": {" +
                    "\"Min\": 0," +
                    "\"Max\": 400" +
                "}," +
                "\"Navigation\": \"computers\"," +
                "\"IncludeMarketPlace\": false," +
                //"\"Brands\": [" +
                //"\"eastpak\"" +
                //"]," +
                "\"Condition\": null" +
            "}" +
        "}" +
    "}"
        /*
        {
        "ApiKey": "3a3d204e-5109-40ae-a924-b1995038dd29",
            "SearchRequest": {
                "Keyword": "tablette",
                "SortBy": "relevance",
                "Pagination": {
                    "ItemsPerPage": 5,
                    "PageNumber": 0
                },
                "Filters": {
                    "Price": {
                        "Min": 0,
                        "Max": 400
                    },
                "Navigation": "computers",
                "IncludeMarketPlace": false,
                "Brands": [
                    "asus"
                ],
                "Condition": null
                }
            }
        }
*/
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        request.HTTPMethod = "POST"
        request.setValue("text/plain; charset=UTF-8", forHTTPHeaderField: "Content-Type")


        // send the request
        let responseData:NSData! =  NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)

        // look at the response
        if let httpResponse = response as? NSHTTPURLResponse {
            println("HTTP response: \(httpResponse.statusCode)")
            //println("HTTP response BODY: \(httpResponse)")

        } else {
            println("No HTTP response")
        }
        
        
        let jsonDict = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String: AnyObject]
        println("Response Data : \(jsonDict)")

        /*
        {
        "ApiKey": "3a3d204e-5109-40ae-a924-b1995038dd29",
        "SearchRequest": {
            "Keyword": "tablette",
            "SortBy": "relevance",
            "Pagination": {
                "ItemsPerPage": 5,
                "PageNumber": 0
                },
            "Filters": {
                "Price": {
                    "Min": 0,
                    "Max": 400
                    },
                "Navigation": "computers",
                "IncludeMarketPlace": false,
                "Brands": [
                "apple"
                ],
                "Condition": null
                }
            }
        }
        */
        
        
        //var json:[String:String] = ["productName":"COCO"]
        //var data = [Dictionary<String, String>]()
        
        //let data = "{\"ItemCount\":\"34\",\"PageCount\": \"7\",\"PageNumber\": \"0\",\"Products\": [{}}"
        /*
        {
            "ItemCount": "34",
            "PageCount": "7",
            "PageNumber": "0",
            "Products": [
            {
            "AssociatedProducts": null,
            "BestOffer": {
                "Condition": "New",
                "Id": "MD531NFA",
                "IsAvailable": true,
                "PriceDetails": {
                        "Discount": null,
                        "ReferencePrice": "249.00",
                        "Saving": {
                            "Type": "Amount",
                            "Value": "17.0"
                            }
                    },
                "ProductURL": "http://www.cdiscount.com/opa.aspx/?trackingid=T1mQnsY6DVL2nQMfDBv95HJiDedNp6Iusby9wMMBIWJ8xCUTe2ax25EOmRJ_4IkI&action=product&id=MD531NFA",
                "SalePrice": "231.98",
                "Seller": {
                    "Id": "0",
                    "Name": "Cdiscount"
                    },
                "Shippings": null,
                "Sizes": null
                },
            "Brand": "APPLE",
            "Description": "Tablette tactile avec écran 7,9\" capacitif - Processeur Apple A5 bicoeur - Stockage 16Go - WiFi 802.11 b/g/n - Camera avant 1,2Mpixels - Caméra arrière 5Mpixels - Connecteur Lightning reversible - Jusqu’à 10h d'autonomie - IOS 6 - Garantie 1 an",
            "Ean": null,
            "Id": "MD531NFA",
            "Images": null,
            "MainImageUrl": "http://i2.cdscdn.com/pdt2/N/F/A/1/300x300/MD531NFA.jpg",
            "Name": "Apple iPad mini Wi-Fi 16 Go blanc & argent",
            "Offers": null,
            "OffersCount": "10",
            "Rating": "4.69"
            }
            ]
        }
*/
        //1
        
        
        /*
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
        */
        //
        //https://api.cdiscount.com/OpenApi/json/Search
        /*
        {
        "ApiKey": "3a3d204e-5109-40ae-a924-b1995038dd29",
        "SearchRequest": {
        "Keyword": "tablette",
        "SortBy": "relevance",
        "Pagination": {
        "ItemsPerPage": 5,
        "PageNumber": 0
        },
        "Filters": {
        "Price": {
        "Min": 0,
        "Max": 400
        },
        "Navigation": "computers",
        "IncludeMarketPlace": false,
        "Brands": [
        "apple"
        ],
        "Condition": null
        }
        }
        }
*/
        
        var processedDico:NSDictionary = processAnswers(jsonDict!)
        
        return processedDico
    }
    
    private func processAnswers(jsonObject : [String:AnyObject]) -> NSDictionary
    {
        var processedAnswers:NSDictionary = [:]

        if let products: AnyObject = jsonObject["Products"]{
            
            for aProduct in products as! NSArray{
                
                for aKey in (aProduct as! NSDictionary).allKeys{
                    if aKey as! String == "Name"{
                        if let name: AnyObject = aProduct["Name"]{
                            println("Product : \(name) ->")
                        }
                    }
                    if aKey as! String == "BestOffer"{
                        if let offers: AnyObject = aProduct["BestOffer"]{
                            for offerDetail in (offers as! NSDictionary).allKeys{
                                if offerDetail as! String == "SalePrice"{
                                    if let price: AnyObject = offers["SalePrice"]{
                                        println("|--> Price: \(price)")
                                    }
                                }
                                
                            }
                        }
                    }
                    
                    /*
                    for (productName,price) in value as!NSDictionary{
                    if(isPertinent(productName as! String)) {processedAnswers.setValue(price, forKey: productName as! String) }
                    }
*/
                    
                }
                
            }
            
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
        var numRows = n + 1
        var numColumns = m + 1
        
        var distance = Array<Array<Int>>()
        
        
        //var distance = [Int:Int]() // matrix
        //var answers:[String:String] = ["productName":"product1","price":"11"]
        
        var cost=0;
        
        if(n == 0) {return Double(m)}
        if(m == 0) {return Double(n)}
        //init1
        // REF :
        /*
        for(int i=0; i <= n; distance[i, 0]=i++);// toutes les lignes sont numérotées de 1 à n
        for(int j=0; j <= m; distance[0, j]=j++);// toutes les colonnes sont numérotées de 1 à n
        */
        for column in 0...numColumns {
            distance.append(Array(count:numRows, repeatedValue:Int()))
        }
        var index = 0
        for row in 0...numRows {
            
            distance[0][index] = index++
            
            println("column: \(0) row: \(row) value:\(distance[0][row])")
            
        }
        var index2 = 0
        for column in 0...numColumns {
            
            distance[index2][0] = index2++
            println("column: \(column) row: \(0) value:\(distance[column][0])")
            
        }
        
        for column in 0...numColumns {
            for row in 0...numRows {
                println("column: \(column) row: \(row) value:\(distance[column][row])")
                
            }
        }
        
        
        //find min distance
        
        for(var i=1; i <= n; i++)
        {
            for(var j=1; j <= m;j++)
            {
                //str.substringWithRange(Range<String.Index>(start: advance(str.startIndex, 2), end: advance(str.endIndex, -1)))
                // TO TRANSFORM : cost=(t.Substring(j - 1, 1) == s.Substring(i - 1, 1) ? 0 : 1);
                cost=stringToCompare.substringWithRange(Range<String.Index>(start: advance(stringToCompare.startIndex, j-1),end: advance(stringToCompare.startIndex, j))) == refString.substringWithRange(Range<String.Index>(start: advance(refString.startIndex, i-1),end: advance(refString.startIndex, i))) ? 0 : 1
                
                
                
                distance[i][j] = min3(
                    distance[i - 1][j] + 1,
                    b: distance[i][j - 1] + 1,
                    c: distance[i - 1][j - 1] + cost
                )

            }
        }
        return Double(distance[n][m]);
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
    
    func min3(a: Int, b: Int, c: Int) -> Int {
        return min(min(a, b), c)
    }
}
/*
SEARCH RESULTS :
{
"ItemCount": "34",
"PageCount": "7",
"PageNumber": "0",
"Products": [
{
"AssociatedProducts": null,
"BestOffer": {
"Condition": "New",
"Id": "MD531NFA",
"IsAvailable": true,
"PriceDetails": {
"Discount": null,
"ReferencePrice": "249.00",
"Saving": {
"Type": "Amount",
"Value": "17.0"
}
},
"ProductURL": "http://www.cdiscount.com/opa.aspx/?trackingid=T1mQnsY6DVL2nQMfDBv95HJiDedNp6Iusby9wMMBIWJ8xCUTe2ax25EOmRJ_4IkI&action=product&id=MD531NFA",
"SalePrice": "231.98",
"Seller": {
"Id": "0",
"Name": "Cdiscount"
},
"Shippings": null,
"Sizes": null
},
"Brand": "APPLE",
"Description": "Tablette tactile avec écran 7,9\" capacitif - Processeur Apple A5 bicoeur - Stockage 16Go - WiFi 802.11 b/g/n - Camera avant 1,2Mpixels - Caméra arrière 5Mpixels - Connecteur Lightning reversible - Jusqu’à 10h d'autonomie - IOS 6 - Garantie 1 an",
"Ean": null,
"Id": "MD531NFA",
"Images": null,
"MainImageUrl": "http://i2.cdscdn.com/pdt2/N/F/A/1/300x300/MD531NFA.jpg",
"Name": "Apple iPad mini Wi-Fi 16 Go blanc & argent",
"Offers": null,
"OffersCount": "10",
"Rating": "4.69"
}
]
}
*/
