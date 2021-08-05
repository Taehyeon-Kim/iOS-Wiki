import UIKit

protocol Traveling {
    func startTraveling()
    func stopTravling()
    func isTraveling() -> Bool
}

class Canada: Traveling {
    func startTraveling() {
        print("Go to Canada 🇨🇦")
    }
    
    func stopTravling() {
        print("Good Travel")
    }
    
    func isTraveling() -> Bool {
        return true
    }
}
class America: Traveling {
    func startTraveling() {
        print("Go to America 🇺🇸")
    }
    
    func stopTravling() {
        print("The end")
    }
    
    func isTraveling() -> Bool {
        return false
    }
}
 
class Country {
    var country: Traveling
    
    init(to country: Traveling) {
        self.country = country
    }
}

let travelingCountry1 = Country(to: Canada())
let travelingCountry2 = Country(to: America())

print(travelingCountry1.country.startTraveling())
print(travelingCountry2.country.stopTravling())
