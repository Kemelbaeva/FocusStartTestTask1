import Foundation

// 0. Можно (нужно даже) было отдельные классы уместить по отдельным файликам.
// 1. Не совсем понял зачем нужен CustomStringConvertible — кажется хаком,
// можно было бы и без него придумать как доставать данные из калсса, но ладно.

// 2. У пиццы есть поле размер, тип размера Int, но Int может быть отрицательным. Лучше использовать перечисление.
enum PizzaSize {
    case small
    case medium
    case big
}

// 3. Если от класса наследоваться не будем, то лучше ставить слово final.
final class Pizza: CustomStringConvertible {
    // 4. Эти поля не подразумевают изменение в дальнейшем, поэтому лучше сразу ставить let, вместо var.
    let title: String
    let size: PizzaSize
    // 5. Для ингредиентов можно было тоже придумать перечисление, чтобы не писать строчки каждый раз, боясь сделать опечатку.
    let ingredients: [String]
    let price: Int
    
    init(title: String, size: PizzaSize, ingredients: [String], price: Int) {
        self.title = title
        self.size = size
        self.ingredients = ingredients
        self.price = price
    }

    // 6. На вкус и цвет, но, вместо перегруженного оператора += для String, я бы использовал метод appending.
    // Самый первый \n нужен, чтобы и первая строчка начиналась на новой строчке, а не на той же, где и заголовок.
    var description: String {
        return "\n"
            .appending("title: \(self.title)\n")
            .appending("size: \(self.size)\n")
            .appending("ingredients: \(self.ingredients)\n")
            .appending("price: \(self.price)\n")
    }
}

let margherita = Pizza(title: "margherita", size: .small, ingredients: ["tomatoes", "cheese", "olive oil"], price: 500)
let neapolitano = Pizza(title: "neapolitano", size: .medium, ingredients: ["parmesan", "tomatoes", "basil"], price: 600)
let capricciosa = Pizza(title: "capriccosia", size: .big, ingredients: ["tomatoes", "mozzarella", "artichokes"], price: 650)

final class Customer: CustomStringConvertible {
    let name: String
    let surname: String
    // 7. Возраст отрицательным быть не может, лучше использовать целочисленный тип без знака.
    let age: UInt
    
    init(name: String, surname: String, age: UInt) {
        self.name = name
        self.surname = surname
        self.age = age
    }
    
    var description: String {
        return "\n"
            .appending("name: \(self.name)\n")
            .appending("surname: \(self.surname)\n")
            .appending("age: \(self.age)\n")
    }
}

let customer = Customer(name: "Ivan", surname: "Ivanov", age: 25)

final class Order: CustomStringConvertible {
    let customer: Customer
    let pizza: Pizza
    let quantity: Int
    let date: Date
    let cost: UInt
    
    init(customer: Customer, pizza: Pizza, quantity: Int, date: Date, cost: UInt) {
        self.customer = customer
        self.pizza = pizza
        self.quantity = quantity
        self.date = date
        self.cost = cost
    }
    
    var description: String {
        return "\n"
            .appending("customer: \(self.customer)\n")
            .appending("pizza: \(self.pizza)\n")
            .appending("quantity: \(self.quantity)\n")
            .appending("date: \(self.date)\n")
            .appending("cost: \(self.cost)\n")
    }
}

// 8. NSDate ты здесь приводишь к типу Date, но можно было просто написать Date(), он тоже возвращает сегодняшнюю дату.
let order = Order(customer: customer, pizza: margherita, quantity: 2, date: Date(), cost: 1000)

// 9. writeOrder(order: Order) не очень красиво выглядит. Я бы написал write(order: Order) или writeOrder(_ order: Order)
func write(order: Order) {
    let fileName = "orders"
    // 10. Force-try можно было бы заменить на что-то более безопасное.
    let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
    
    print("File Path: \(fileURL.path)")
    
    let writeString = "ORDER\n\(order)"
    do {
        // 11. Вот такие комментарии мало чем помогают — лучше без них. Тут у тебя код говорит сам за себя, всё хорошо.
        // Write to the file
        try writeString.write(to: fileURL, atomically: true, encoding: .utf8)
    } catch let error {
        print("Failed to write to URL")
        print(error)
    }
}

write(order: order)
