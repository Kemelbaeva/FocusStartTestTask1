
import Foundation

class Pizza : CustomStringConvertible {
    var title : String
    var size : Int
    var ingredients : [String]
    var price : Int
    
    init(title: String, size: Int, ingredients: [String], price: Int) {
        self.title = title
        self.size = size
        self.ingredients = ingredients
        self.price = price
    }
    
    var description: String {
        var description = ""
        description += "title:\(self.title)\n"
        description += "size:\(self.size)\n"
        description += "ingredients:\(self.ingredients)\n"
        description += "price:\(self.price)\n"
        
        return description
    }
}


let pizzaMargherita = Pizza(title: "margherita", size: 30, ingredients: ["tomatoes", "cheese", "olive oil"], price: 500)
let pizzaNeapolitano = Pizza(title: "neapolitano", size: 35, ingredients: ["parmesan", "tomatoes", "basil"], price: 600)
let pizzaCapricciosa = Pizza(title: "capriccosia", size: 35, ingredients: ["tomatoes", "mozzarella", "artichokes"], price: 650)

class Customer: CustomStringConvertible {
    var name : String
    var surname : String
    var age : Int
    
    init(name: String, surname: String, age: Int) {
        self.name = name
        self.surname = surname
        self.age = age
    }
    
    var description: String {
        var description = ""
        description += "name:\(self.name)\n"
        description += "surname:\(self.surname)\n"
        description += "age:\(self.age)\n"
        
        return description
    }
}

let customer1 = Customer(name: "Ivan", surname: "Ivanov", age: 25)
let customer2 = Customer(name: "Petr", surname: "Petrov", age: 23)
let customer3 = Customer(name: "Sergei", surname: "Sergeev", age: 30)

class Order: CustomStringConvertible {
    var customer: Customer
    var pizza: Pizza
    var quantity: Int
    var date: Date
    var cost: Int
    
    init(customer: Customer, pizza: Pizza, quantity: Int, date: Date, cost: Int ) {
        self.customer = customer
        self.pizza = pizza
        self.quantity = quantity
        self.date = date
        self.cost = cost
    }
    
    var description: String {
        var description = ""
        description += "customer: \(self.customer)\n"
        description += "pizza: \(self.pizza)\n"
        description += "quantity:\(self.quantity)\n"
        description += "date:\(self.date)\n"
        description += "cost:\(self.cost)\n"
        
        return description
    }
}

let order1 = Order(customer: customer1, pizza: pizzaMargherita, quantity: 2, date: NSDate() as Date, cost: 1000)

func writeOrder(order: Order) {
    let fileName = "orders"
    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
    
    print("File Path: \(fileURL.path)")
    
let writeString = "ORDER\n\(order)"
    do {
        // Write to the file
        try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
    } catch let error as NSError {
        print("Failed to write to URL")
        print(error)
    }
}

writeOrder(order: order1)

