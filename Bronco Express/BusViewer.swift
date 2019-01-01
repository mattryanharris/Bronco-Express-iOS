//
//  BusViewer.swift
//  TestTest
//
//  Created by Matthew Harris on 12/29/18.
//  Copyright © 2018 Matthew Harris. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

struct Shuttle: Codable {
    let routeID, stopID, vehicleID, welcomeStopID: Int?
    let welcomeVehicleID: Int?
    let arriveTime: String
    let welcomeRouteID, direction: Int
    let schedulePrediction, isLayover: Bool
    let rules: [String]
    let scheduledTime: String?
    let secondsToArrival: Double
    let isLastStop, onBreak: Bool
    let scheduledArriveTime: String?
    let scheduledMinutes: Float
    let tripID: String?
    let busName, vehicleName, routeName: String
    let minutes: Int
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case routeID = "RouteID"
        case stopID = "StopID"
        case vehicleID = "VehicleID"
        case welcomeStopID = "StopId"
        case welcomeVehicleID = "VehicleId"
        case arriveTime = "ArriveTime"
        case welcomeRouteID = "RouteId"
        case direction = "Direction"
        case schedulePrediction = "SchedulePrediction"
        case isLayover = "IsLayover"
        case rules = "Rules"
        case scheduledTime = "ScheduledTime"
        case secondsToArrival = "SecondsToArrival"
        case isLastStop = "IsLastStop"
        case onBreak = "OnBreak"
        case scheduledArriveTime = "ScheduledArriveTime"
        case scheduledMinutes = "ScheduledMinutes"
        case tripID = "TripId"
        case busName = "BusName"
        case vehicleName = "VehicleName"
        case routeName = "RouteName"
        case minutes = "Minutes"
        case time = "Time"
    }
}

class BusViewer: UIViewController {
    @IBOutlet weak var RouteName: UIButton!
    @IBOutlet weak var stopName: UIButton!
    
    @IBOutlet weak var busID: UILabel!
    @IBOutlet weak var arrivalMin: UILabel!
    @IBOutlet var eta: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    
    var shuttles = [Shuttle]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        RouteName.setTitle(currentRoute, for: UIControl.State.normal)
        stopName.setTitle(currentStop, for: UIControl.State.normal)
        
        var routeNum = "3164"
        
        
        if currentRoute == "Route A" {
            routeNum = "3164"
        } else if currentRoute == "Route B" {
            routeNum = "4512"
        } else if currentRoute == "Route B2" {
            routeNum = "4513"
        } else if currentRoute == "Route C" {
            routeNum = "4515"
        }
        
        print(routeNum)
        
        
        //let API_URL = "https://broncoshuttle.com/Route/" + routeNum + "/Stop/" + String(currentStopID)  + "/Arrivals?customerID=21"
        
        URLCache.shared.removeAllCachedResponses()
        
        let API_URL = "https://www.cpp.edu/~mrharris/" + routeNum + String(currentStopID) + ".json"
        
        print(API_URL)

        //let API_URL = "https://www.cpp.edu/~mrharris/demoJSON.json"
        
        
        AF.request(API_URL).responseJSON { response in
            let json = response.data
            
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
                self.shuttles = try decoder.decode([Shuttle].self, from: json!)
                
                //printing all the bus names
                /* for shuttle in self.shuttles{
                 print(shuttle.minutes)
                 print(shuttle.busName)
                 self.busID.text = shuttle.busName
                 self.arrivalMin.text = String(shuttle.minutes)
                 }
                 */
                
                
            
                
                self.progress.trackTintColor = #colorLiteral(red: 0.8900991082, green: 0.8902519345, blue: 0.8900894523, alpha: 1)
                
                self.progress.progressTintColor = #colorLiteral(red: 0, green: 0.7798785567, blue: 0, alpha: 1)
                
                self.progress.layer.cornerRadius = 5
                self.progress.clipsToBounds = true
                
                if self.shuttles.isEmpty == true {
                    print("There are no buses")
                    self.busID.text = String("There are no active buses")
                }
                    
                    
                else {
                    self.busID.text = String("Bus ") + self.shuttles[0].busName
                    
                    var progressPercent : Float = 1
                    
                    if (self.shuttles[0].minutes != 0){
                        progressPercent =  1 - (Float(self.shuttles[0].minutes) / 30)
                    }
                    
                    print(progressPercent)
                    print(self.shuttles[0].secondsToArrival)
                    
                    self.eta.text = "ETA @ " + self.shuttles[0].arriveTime
                    
                    self.progress.setProgress(Float(progressPercent), animated: true)
                    if self.shuttles[0].minutes == 0 {
                        self.arrivalMin.text = "The shuttle is arriving shortly"
                    } else {
                        self.arrivalMin.text = String(self.shuttles[0].minutes) + String(" minutes until arrival")
                    }
                }
            } catch let err{
                print(err)
            }
        }
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DirectSegue" {
            guard segue.destination is StopTableController else {return}
            
            guard let cell = sender as? UITableViewCell else { return }
            
            currentRoute = (cell.textLabel?.text)!
        }
}

}
