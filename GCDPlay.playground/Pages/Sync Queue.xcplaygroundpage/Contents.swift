import Foundation

let queue = DispatchQueue(label: "com.makeschool.queue")

queue.async {
    for i in 0..<10 {
        print("🍎 ", i)
    }
}

for i in 100..<110 {
    print("🐳 ", i)
}

/*
 This will cause the program to print all the apples first, adn then print all the whales in order.
 
 However, if we change .sync to .async, the apples and whales will be printed mixed up all together, in no specific order of the apple coming first or the whale coming first
*/

