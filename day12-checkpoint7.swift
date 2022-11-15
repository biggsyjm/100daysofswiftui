//day 12 checkpoint 7

class Animal {
    let legs: Int
    init(legs: Int) {
        self.legs = legs}}
class Dog: Animal {
    func speak() {
            print("woof woof bow wow wow")}}
class Corgi: Dog {
    override func speak() {
        print("yap yap yap yap")}}
class Poodle: Dog {
    override func speak() {
        print("arf arf arf arf ")}}

class Cat: Animal {
    var isTame: Bool
    func speak() {
            print("meow meow meow")}
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)}}
class Persian: Cat {
    override func speak() {
        print("meooooooooooooow")}}
class Lion: Cat {
    override func speak() {
        print("ROOOAAAARRRRR")}}

let brandy = Corgi(legs: 4)
brandy.speak()
let oscar = Poodle(legs: 4)
oscar.speak()
let sansa = Persian(isTame: true)
sansa.speak()
let simba = Lion(isTame: false)
simba.speak()
