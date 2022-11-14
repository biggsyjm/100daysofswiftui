struct Car {
    let model: String
    let seats: Int
    private var gear = 1
    init(model: String, seats: Int) {
           self.model = model
           self.seats = seats
       }
    mutating func changeGear(up: Bool) {
        if up {
            if gear <= 9 {
                gear += 1
                print("Changed to \(gear) gear")
            }
            else {
                print("Gear can't go any higher")
            }
        }
        else {
            if gear > 1 {
                gear -= 1
                print("Lowered to \(gear) gear")
            }
            else {
                print("Gear can't go any lower")
            }
        }
    }
}

var honda = Car(model: "Odyssey", seats: 9)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: true)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
honda.changeGear(up: false)
