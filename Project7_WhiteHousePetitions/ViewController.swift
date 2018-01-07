//
//  ViewController.swift
//  Project7_WhiteHousePetitions
//
//  Created by Sabrina Fletcher on 1/5/18.
//  Copyright © 2018 Sabrina Fletcher. All rights reserved.
//

//Tab Bar manages array of view controllers

import UIKit

class ViewController: UITableViewController{
    
    var petitions = [[String: String]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                let json = JSON(data: data)
                print("Created JSON")
                
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    //We're ok to parse
                    print("We parsed")
                    parse(json: json)
                } else{
                    print(json["metadata"]["responseInfo"]["status"].intValue)
                }
            }
        }
        
    }
    
    func parse(json: JSON){
        for result in json["results"].arrayValue{
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]

            petitions.append(obj)
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Title Goes Here"
        cell.detailTextLabel?.text = "Subtitle Goes Here"
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

