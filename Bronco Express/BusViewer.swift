import UIKit
import Alamofire
import Foundation
import PopupDialog

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

    func getCurrentTime() {
        let hourFormat = DateFormatter()
        let minFormat = DateFormatter()
        let dayFormat = DateFormatter()
        
        hourFormat.dateFormat = "HH"
        minFormat.dateFormat = "mm"
        dayFormat.dateFormat = "EEEE"
        
        let day = dayFormat.string(from: Date())
        let hour = hourFormat.string(from: Date())
        let min = minFormat.string(from: Date())
        
        print(hour)
        
        if (day == "Monday" || day == "Tuesday" || day == "Wednesday" || day == "Thursday") {
            if (Int(hour)! >= 22) || (Int(hour)! <= 6) {
                showImageDialog()
            }
            
            if(Int(hour)! == 22 && Int(min)! > 30) || (Int(hour)! == 7 && Int(min)! <= 30) {
                showImageDialog()
            }
        }
            
        else if (day == "Friday") {
            if (Int(hour)! >= 17) || (Int(hour)! <= 7) {
                showImageDialog()
            }
            
            if(Int(hour)! == 16 && Int(min)! > 30) || (Int(hour)! == 7 && Int(min)! <= 30) {
                showImageDialog()
            }
        }
            
        else {
            showImageDialog()
        }
    }
    
    func showImageDialog(animated: Bool = true) {
        let title = "Not In Service At This Time"
        let message = "It is past normal operating hours, no active buses are running at this time."
        let image = UIImage(named: "night")
        
        let popup = PopupDialog(title: title, message: message, image: image, preferredWidth: 580)
    
        let button = DefaultButton(title: "OK") {}
        
        popup.addButtons([button])
        
        self.present(popup, animated: animated, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentTime()
  
        RouteName.setTitle(currentRoute, for: UIControl.State.normal)
        stopName.setTitle(currentStop, for: UIControl.State.normal)
        
        var routeNum = "3164"
    
        if currentRoute == "Route A" {
            routeNum = "3164"
        } else if currentRoute == "Route B" {
            routeNum = "4512"
        } else if currentRoute == "Route B2 via Lyle Ctr" {
            routeNum = "4513"
        } else if currentRoute == "Route C" {
            routeNum = "4515"
        } else if currentRoute == "Route D Express" {
            routeNum = "11512"
        }
        
        URLCache.shared.removeAllCachedResponses()

        let API_URL = "https://broncoshuttle.com/Route/" + routeNum + "/Stop/" + String(currentStopID)  + "/Arrivals?customerID=21"
        
        AF.request(API_URL).responseJSON { response in
           
            let json = response.data
            
            do {
                let decoder = JSONDecoder()
                
                self.shuttles = try decoder.decode([Shuttle].self, from: json!)
                
                self.progress.trackTintColor = #colorLiteral(red: 0.8900991082, green: 0.8902519345, blue: 0.8900894523, alpha: 1)
                self.progress.progressTintColor = #colorLiteral(red: 0.002084276134, green: 0.7340346481, blue: 0.003233944196, alpha: 1)
                self.progress.layer.cornerRadius = 5
                self.progress.clipsToBounds = true
                
                if self.shuttles.isEmpty == true {
                    print("There are no buses")
                    self.busID.text = String("No Active Buses")
                    self.arrivalMin.text = "Try refreshing, nothing active"
                    self.eta.text = "TBD"
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
            guard segue.destination is StopTableController else { return }
            guard let cell = sender as? UITableViewCell else { return }
            currentRoute = (cell.textLabel?.text)!
        }
    }
}
