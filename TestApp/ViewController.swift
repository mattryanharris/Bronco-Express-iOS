//
//  ViewController.swift
//  TestApp
//
//  Created by Matthew Harris on 11/26/18.
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

class ViewController: UIViewController {
    
    
    var shuttles = [Shuttle]()
    
    var currentRoute = "Route A"
    var currentStop = "South Campus/Temple"
    
    let routeData = ["Route A", "Route B", "Route B2 via Lyle Ctr", "Route C"]
    
    let routeAData = ["South Campus/Temple", "Overflow Parking Lot", "Innovation Way at IBM"]
    
    let routeBData = ["South Campus/Temple", "Overflow Parking Lot", "Innovation Way at IBM"]
    
    let routeB2Data = ["South Campus/Temple", "Overflow Parking Lot", "Innovation Way at IBM"]
    
    let routeCData = ["Test", "Overflow Parking Lot", "Innovation Way at IBM"]

    @IBOutlet weak var busID: UILabel!
    @IBOutlet weak var arrivalMin: UILabel!
    @IBOutlet var eta: UILabel!
    @IBOutlet var route: UIPickerView!
    @IBOutlet var stop: UIPickerView!
    @IBOutlet weak var progress: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var routeNum = "3164"
        var stopNum = "33803"
        
        if currentRoute == "Route A" {
            routeNum = "3164"
        } else if currentRoute == "Route C" {
            routeNum = "4515"
        }
        
        if currentStop == "South Campus/Temple" {
            stopNum = "36359"
        }  else if currentStop == "Overflow Parking Lot" {
            stopNum = "1592066"
        } else if currentStop == "Innovation Way at IBM" {
            stopNum = "1592165"
        }
        
        let API_URL = "https://broncoshuttle.com/Route/" + routeNum + "/Stop/" + stopNum + "/Arrivals?customerID=21"
        
        print(API_URL)
        
        self.route.delegate = self
        self.route.dataSource = self
        
        self.stop.delegate = self
        self.stop.dataSource = self
        
        Alamofire.request(API_URL).responseJSON { response in
            let json = response.data
            
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
                self.shuttles = try decoder.decode([Shuttle].self, from: json!)
                
                //printing all the hero names
                /* for shuttle in self.shuttles{
                    print(shuttle.minutes)
                    print(shuttle.busName)
                    self.busID.text = shuttle.busName
                    self.arrivalMin.text = String(shuttle.minutes)
                }
                */
                
                //self.progress.transform = self.progress.transform.scaledBy(x: 1, y: 5)
                self.progress.trackTintColor = #colorLiteral(red: 0.8900991082, green: 0.8902519345, blue: 0.8900894523, alpha: 1)
                
                self.progress.progressTintColor = #colorLiteral(red: 0, green: 0.7798785567, blue: 0, alpha: 1)
                
                self.progress.layer.cornerRadius = 5
                self.progress.clipsToBounds = true
               
                print(self.currentRoute)
                print(self.currentStop)
                
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
                
            }catch let err{
                print(err)
            }

        }
    }

    @IBAction func refresh(_ sender: Any) {
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == route {
            return routeData.count
        } else if pickerView == stop{
            if currentRoute == "Route A" {
                return routeAData.count
            }
                
            else if currentRoute == "Route B" {
                return routeBData.count
            }
                
            else if currentRoute == "Route B2" {
                return routeB2Data.count
            }
                
            else if currentRoute == "Route C" {
                return routeCData.count
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == route {
            currentRoute = routeData[row]
        } else if pickerView == stop{
            if currentRoute == "Route A" {
                currentStop = routeAData[row]
            }
                
            else if currentRoute == "Route B" {
                currentStop = routeBData[row]
            }
                
            else if currentRoute == "Route B2" {
                currentStop = routeB2Data[row]
            }
                
            else if currentRoute == "Route C" {
                currentStop = routeCData[row]
            }
        }
        currentRoute = routeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == route {
            return routeData[row]
        } else if pickerView == stop{
            if currentRoute == "Route A" {
                return routeAData[row]
            }
            
            else if currentRoute == "Route B" {
                return routeBData[row]
            }
            
            else if currentRoute == "Route B2" {
                return routeB2Data[row]
            }
            
            else if currentRoute == "Route C" {
                return routeCData[row]
            }
        }
        return "Test"
    }
}

