import Cocoa

//day 14 checkpoint 9

let myNumbers: [Int]? = [8,3,1,45,23,9,76]

let randNumber = myNumbers?.randomElement() ?? Int.random(in: 1...100)

//print(randNumber)



// I love optionals!

var optionals: [String]?

func doIloveIt(it: [String]?) {
    guard let optionals = optionals else {
        print("I still love optionals")
        return
    }
    print("And \(optionals) love me too")
}

doIloveIt(it: optionals)
