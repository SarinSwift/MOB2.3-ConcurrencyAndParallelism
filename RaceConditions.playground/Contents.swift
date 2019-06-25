import UIKit

var array = [Int]()

// This causes an error!!! Becasue there are many things happening but it's because there's a shared resource var array that many threads are trying to get access from. We need to protect the shared resource!!! Which is the array
//DispatchQueue.concurrentPerform(iterations: 100) { (index) in
//    let last = array.last ?? 0
//    array.append(last + 1)
//    print(array)
//}


// FIXED the race condition by using the NSLock
//let lock = NSLock()
//DispatchQueue.concurrentPerform(iterations: 100) { (index) in
//    lock.lock()
//    let last = array.last ?? 0
//    array.append(last + 1)
//    lock.unlock()
//    print(array)
//}

// FIXED using semaphores
let sem = DispatchSemaphore(value: 1)   // we want 1 thread to access at a time

DispatchQueue.concurrentPerform(iterations: 100) { (index) in
    sem.wait()      //  value goes down to 0
    let last = array.last ?? 0
    array.append(last + 1)
    sem.signal()    // value goes up to 1
    print(array)
}
