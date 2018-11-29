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
    var currentStop = "36359"
    
    
    let routeData = ["Route A", "Route B", "Route B2", "Route C"]
    
    let routeAData = ["South Campus/Temple", "Overflow Parking Lot", "Innovation Way at IBW", "Camphor Lane/Lot M", "Campus Center Market", "Camphor Lane", "Building 7 - Enviormental Design", "Building 94", "Rose Garden", "Building 91", "CLA", "Parking Structure", "Red Gum/Univ. Dr/Lot F2", "Resident Halls", "Building 91", "Student Health Services"]
    
    let routeBData = ["Interim Design Center Building 89", "Oak Lane/F Lots", "Cypress Lane/F Lots", "Residents Hall", "Building 1", "Student Health Services", "Collins College/Kellogg West (Southbound)", "Agriscapes/Farm Store", "South Campus/Temple", "Collins College/Kellogg West (Northbound)", "Building 7 - Enviormental Science", "Building 94", "Rose Garden/College of Business", "University Police/Parking Services"]
    
    let routeB2Data = ["Interim Design Center Building 89", "Oak Lane/F Lots", "Cypress Lane/F Lots", "Residents Hall", "Building 1", "Student Health Services", "Collins College/Kellogg West (Southbound)", "Regenerative Studies", "Agriscapes/Farm Store", "South Campus/Temple", "Collins College/Kellogg West (Northbound)", "Building 7 - Enviormental Design", "Building 94", "Rose Garden/College of Business", "University Police/Parking Services"]
    
    let routeCData = ["Parking Lot B", "PS2 Southeast", "PS2 Northeast", "Camphor Lane/Lot M", "Campus Center Marketplace", "Camphor Lane", "PS2 Northwest", "PS2 Southwest"]
    
    var routeAStops: [String:Int] = [
        "South Campus/Temple" : 36359,
        "Overflow Parking Lot" : 1592066,
        "Innovation Way at IBW" : 1592165,
        "Camphor Lane/Lot M" : 35348,
        "Campus Center Market" : 35362,
        "Camphor Lane" : 35377,
        "Building 7 - Enviormental Design" : 48396,
        "Building 94" : 33803,
        "Rose Garden" : 33817,
        "Building 91" : 33835,
        "CLA" : 33851,
        "Parking Structure" : 486770,
        "Red Gum/Univ. Dr/Lot F2" : 486771,
        "Resident Halls" : 486772,
        "Building 1" : 486773,
        "Student Health Services" : 34999
    ]
    
    var routeBStops : [String:Int] = [
        "Interim Design Center Building 89" : 487167,
        "Oak Lane/F Lots" : 485416,
        "Cypress Lane/F Lots" : 487168,
        "Residents Hall" : 487169,
        "Building 1" : 486773,
        "Student Health Services" : 34999,
        "Collins College/Kellogg West (Southbound)" : 1231738,
        "Agriscapes/Farm Store" : 487171,
        "South Campus/Temple" : 36359,
        "Collins College/Kellogg West (Northbound)" : 485601,
        "Building 7 - Enviormental Science" : 48396,
        "Building 94" : 33803,
        "Rose Garden/College of Business" : 487172,
        "University Police/Parking Services" : 487173
    ]
    
    var routeB2Stops : [String:Int] = [
        "Interim Design Center Building 89" : 487167,
        "Oak Lane/F Lots" : 485416,
        "Cypress Lane/F Lots" : 487168,
        "Residents Hall" : 487169,
        "Building 1" : 486773,
        "Student Health Services" : 34999,
        "Collins College/Kellogg West (Southbound)" : 1231738,
        "Regenerative Studies" : 487170,
        "Agriscapes/Farm Store" : 487171,
        "South Campus/Temple" : 36359,
        "Collins College/Kellogg West (Northbound)" : 485601,
        "Building 7 - Enviormental Design" : 48396,
        "Building 94" : 33803,
        "Rose Garden/College of Business" : 487172,
        "University Police/Parking Services" : 487173
    ]
    
    var routeCStops : [String:Int] = [
        "Parking Lot B" : 35317,
        "PS2 Southeast" : 2310798,
        "PS2 Northeast" : 2310799,
        "Camphor Lane/Lot M" : 35348,
        "Campus Center Marketplace" : 35362,
        "Camphor Lane" : 35377,
        "PS2 Northwest" : 2310800,
        "PS2 Southwest" : 2310801,
    ]
    
    var selectedRoute : [String:Int]?
    
    @IBOutlet weak var busID: UILabel!
    @IBOutlet weak var arrivalMin: UILabel!
    @IBOutlet var eta: UILabel!
    @IBOutlet var route: UIPickerView!
    @IBOutlet var stop: UIPickerView!
    @IBOutlet weak var progress: UIProgressView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
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
        
        //let API_URL = "https://broncoshuttle.com/Route/" + routeNum + "/Stop/" + currentStop + "/Arrivals?customerID=21"
        
        let API_URL = "https://www.cpp.edu/~mrharris/demoJSON.json"
        
        print(API_URL)
        print(API_URL)
        print(API_URL)
        
        self.route.delegate = self
        self.route.dataSource = self
        
        self.stop.delegate = self
        self.stop.dataSource = self
        
        // fatal error testing for custom font loading
        /*guard let customFont = UIFont(name: "Lato-Light", size: 20.0) else {
            fatalError("""
        Failed to load the "CustomFont-Light" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        
        arrivalMin.font = UIFontMetrics.default.scaledFont(for: customFont) */
            
        self.eta.font = UIFont(name: "Lato-Light", size: 15.0)
        
        Alamofire.request(API_URL).responseJSON { response in
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
            } catch let err{
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
                if let identifier = routeAStops[routeAData[row]] {
                        currentStop = String(identifier)
                }
                
            }
                
            else if currentRoute == "Route B" {
                if let identifier = routeBStops[routeBData[row]] {
                    currentStop = String(identifier)
                }
            }
                
            else if currentRoute == "Route B2" {
                if let identifier = routeB2Stops[routeB2Data[row]] {
                    currentStop = String(identifier)
                }
            }
                
            else if currentRoute == "Route C" {
                if let identifier = routeCStops[routeCData[row]] {
                    currentStop = String(identifier)
                }
            }
        }
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

