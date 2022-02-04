import UIKit

// GENERICS

protocol Pet {
    var name: String {get}
}

protocol Meowable {
    func meow()
}

class Cat: Pet {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

extension Cat: Meowable {
    func meow() {
        print("\(self.name) says meow")
    }
}

class Dog: Pet {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

// Avoid using T for generics
// Can limit generic to protocol or class, otherwise <String> is working as well
class Keeper<Animal: Pet> {
    var name: String
    // Can use generic as type
    var morningCare: Animal
    var eveningCare: Animal
    
    init(_ name: String,
         morningCare: Animal,
         eveningCare: Animal) {
        self.name = name
        self.morningCare = morningCare
        self.eveningCare = eveningCare
    }
}



// aCatKeeper and aDogKeeper are specific types
let aCatKeeper = Keeper<Cat>("Jason",
                            morningCare: Cat("Jerry"),
                            eveningCare: Cat("Pissi"))
let aDogKeeper = Keeper<Dog>("Ann",
                            morningCare: Dog("Grumpy"),
                            eveningCare: Dog("Huskie"))

// Arrays are Generics
// where means we can call meow only for elements that inherit or adopt the Meowable protocol
extension Array: Meowable where Element: Meowable {
    func meow() {
        forEach { $0.meow() }
    }
}

let catArray = [Cat("Tommy"), Cat("Sleepy")]
catArray.meow()

// Generic Optionals
// Optionals are enum and generics
enum myOptional<T> {
    case none
    case some(T)
}



