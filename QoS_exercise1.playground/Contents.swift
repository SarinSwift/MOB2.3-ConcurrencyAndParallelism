import Foundation

let queue1 = DispatchQueue(label: "com.makeschool.queue1", qos: DispatchQoS.background)
let queue2 = DispatchQueue(label: "com.makeschool.queue2", qos: DispatchQoS.userInteractive)

// These 2 queues will print out mostly whales first and then apples because of the QoS we adjusted ourselves

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
