import Foundation

struct Route {
    let routeName: String
    let routeID: Int
    let stop: [Stop]
    
    static let routes = [
        Route(routeName: "Route A", routeID: 3164, stop: [
            Stop(stopName: "South Campus/Temple", stopID: 36359),
            Stop(stopName: "Overflow Parking Lot", stopID: 1592066),
            Stop(stopName: "Innovation Way at IBW", stopID: 1592165),
            Stop(stopName: "Camphor Lane/Lot M", stopID: 35348),
            Stop(stopName: "Campus Center Market", stopID: 35362),
            Stop(stopName: "Camphor Lane", stopID: 35377),
            Stop(stopName: "Building 7 - Environmental Design", stopID: 48396),
            Stop(stopName: "Building 94", stopID: 33803),
            Stop(stopName: "Rose Garden", stopID: 33817),
            Stop(stopName: "Building 91", stopID: 33835),
            Stop(stopName: "CLA", stopID: 33851),
            Stop(stopName: "Parking Structure", stopID: 486770),
            Stop(stopName: "Red Gum/Univ. Dr/Lot F2", stopID: 486771),
            Stop(stopName: "Resident Halls", stopID: 486772),
            Stop(stopName: "Building 1", stopID: 486773),
            Stop(stopName: "Student Health Services", stopID: 34999)
            ]),
        
        Route(routeName: "Route B", routeID: 4512, stop: [
            Stop(stopName: "Interim Design Center Building 89", stopID: 487167),
            Stop(stopName: "Oak Lane/F Lots", stopID: 485416),
            Stop(stopName: "Cypress Lane/F Lots", stopID: 487168),
            Stop(stopName: "Residents Hall", stopID: 487169),
            Stop(stopName: "Building 1", stopID: 486773),
            Stop(stopName: "Student Health Services", stopID: 34999),
            Stop(stopName: "Collins College/Kellogg West (Southbound)", stopID: 1231738),
            Stop(stopName: "Agriscapes/Farm Store", stopID: 487171),
            Stop(stopName: "South Campus/Temple", stopID: 36359),
            Stop(stopName: "Collins College/Kellogg West (Northbound)", stopID: 485601),
            Stop(stopName: "Building 7 - Environmental Design", stopID: 48396),
            Stop(stopName: "Building 94", stopID: 33803),
            Stop(stopName: "Rose Garden/College of Business", stopID: 487172),
            Stop(stopName: "University Police/Parking Services", stopID: 487173)
            ]),
        
        Route(routeName: "Route B2", routeID: 4513, stop: [
            Stop(stopName: "Interim Design Center Building 89", stopID: 487167),
            Stop(stopName: "Oak Lane/F Lots", stopID: 485416),
            Stop(stopName: "Cypress Lane/F Lots", stopID: 487168),
            Stop(stopName: "Residents Hall", stopID: 487169),
            Stop(stopName: "Building 1", stopID: 486773),
            Stop(stopName: "Student Health Services", stopID: 34999),
            Stop(stopName: "Collins College/Kellogg West (Southbound)", stopID: 1231738),
            Stop(stopName: "Regenerative Studies", stopID: 487170),
            Stop(stopName: "Agriscapes/Farm Store", stopID: 487171),
            Stop(stopName: "South Campus/Temple", stopID: 36359),
            Stop(stopName: "Collins College/Kellogg West (Northbound)", stopID: 485601),
            Stop(stopName: "Building 7 - Environmental Design", stopID: 48396),
            Stop(stopName: "Building 94", stopID: 33803),
            Stop(stopName: "Rose Garden/College of Business", stopID: 487172),
            Stop(stopName: "University Police/Parking Services", stopID: 487173)
            ]),
        
        Route(routeName: "Route C", routeID: 4515, stop: [
            Stop(stopName: "Parking Lot B", stopID: 35317),
            Stop(stopName: "PS2 Southeast", stopID: 2310798),
            Stop(stopName: "PS2 Northeast", stopID: 2310799),
            Stop(stopName: "Camphor Lane/Lot M", stopID: 35348),
            Stop(stopName: "Campus Center Marketplace", stopID: 35362),
            Stop(stopName: "Camphor Lane", stopID: 35377),
            Stop(stopName: "PS2 Northwest", stopID: 2310800),
            Stop(stopName: "PS2 Southwest", stopID: 2310801)
            ])
        ]
    }

var currentRoute = "Route A"
var currentStop = "South Campus/Temple"
var currentStopID = 36359

struct Stop {
    let stopName: String
    let stopID: Int
}
