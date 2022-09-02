import UIKit
import Foundation

class Animal {
    func sound() {}
}

class Cat: Animal {
    override func sound() {
        print("miauw")
    }
}

class Dog: Animal {
    override func sound() {
        print("woof")
    }
}

let kitty = Cat()
kitty.sound()

let bobby = Dog()
bobby.sound()
