import SwiftUI

// Solve it without "Error"

func squareRootCheck(_ value: Int) -> String {
    if value < 1 || value > 10_000 {
        return "Value is out of bounds"
    }
    if value >= 1 || value <= 10_000 {
        for i in 1...100 {
            if i * i == value {
                return "The square root is \(i)"
            }
        }
    }
    
    return "No root found"
}

squareRootCheck(1440)

// Solve it with "Error"

enum SquareError: Error {
    case bounds, none
}
var answer = 0
func checkSquare(_ value: Int) throws -> String {
    if value < 1 || value > 10_000 {
        throw SquareError.bounds
    }
    if value >= 1 || value <= 10_000 {
        for i in 1...100 {
            if i * i == value {
                answer = i
                break
            }
        }
    }
    if answer == 0 {
        throw SquareError.none
    }
    return "The square root is \(answer)"
}

do {
    let result = try checkSquare(1024)
    print("Here you go: \(result)")
} catch SquareError.bounds {
    print("The value is out of bounds.")
} catch SquareError.none {
    print("The square root is not a whole number")
} catch {
    print("There was an error.")
}
