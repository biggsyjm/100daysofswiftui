import Cocoa

//day 13 checkpoint 8

protocol Building {
    var rooms: Int { get }
    var price: Int { get set }
    var agent: String { get set }
    
    func salesSummary()
}

struct Office: Building {
    var rooms: Int
    var price: Int
    var agent: String
    func salesSummary() {
        print("Agent \(agent) has a \(rooms) room building for sale for $\(price).")
    }
}

struct House: Building {
    var rooms: Int
    var price: Int
    var agent: String
    func salesSummary() {
        print("Agent \(agent) has a \(rooms) bedroom house for sale for $\(price).")
    }
}

let oaklawnDr = Office(rooms: 23, price: 5_000_000, agent: "Suzy")
oaklawnDr.salesSummary()

let shadowRd = House(rooms: 2, price: 100_000, agent: "Marcus")
shadowRd.salesSummary()




