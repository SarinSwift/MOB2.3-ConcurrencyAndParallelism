import Foundation

let queue1 = DispatchQueue(label: "com.makeschool.queue1", qos: DispatchQoS.userInitiated)
let queue2 = DispatchQueue(label: "com.makeschool.queue2", qos: DispatchQoS.utility)

// This will show both apples and Smilies because the smilies are on the main thread and the apples are executed on the highest priority level queue! Whales will ost likely print out at the end most becasue they are on utility which are slower priority than the other ones

queue1.async {
    for i in 0..<10 {
        print("🍎 ", i)
    }
}

queue2.async {
    for i in 100..<110 {
        print("🐳 ", i)
    }
}

for i in 100..<110 {
    print("😬 ", i)
}
