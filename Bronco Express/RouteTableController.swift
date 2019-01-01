//
//  RouteTableController.swift
//  TestTest
//
//  Created by Matthew Harris on 12/29/18.
//  Copyright © 2018 Matthew Harris. All rights reserved.
//

import UIKit

class RouteTableController: UITableViewController {
    
    let route = Route.routes

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Route"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return route.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = route[indexPath.row].routeName
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            guard let StopTableController = segue.destination as? StopTableController else {return}
            
            guard let cell = sender as? UITableViewCell else { return }
            
            currentRoute = (cell.textLabel?.text)!
            
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            
            
            
            let routes = route[indexPath.row]
            StopTableController.route = routes
            
        }
    }
}
