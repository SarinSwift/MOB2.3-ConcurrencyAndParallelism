import UIKit

// 2 global queues - represent people wanting to play switch
// wait() -> play switch -> signal()

let semaphore = DispatchSemaphore(value: 1)
DispatchQueue.global().async {
    print("Person 1 - wait")
    semaphore.wait()
    print("Person 1 - wait finished")
    sleep(1) // Person 1 playing with Switch
    print("Person 1 - done with Switch")
    semaphore.signal()
}
DispatchQueue.global().async {
    print("Person 2 - wait")
    semaphore.wait()
    print("Person 2 - wait finished")
    sleep(1) // Person 2 playing with Switch
    print("Person 2 - done with Switch")
    semaphore.signal()
}
DispatchQueue.global().async {
    print("Person 3 - wait")
    semaphore.wait()
    print("Person 3 - wait finished")
    sleep(1) // Person 3 playing with Switch
    print("Person 3 - done with Switch")
    semaphore.signal()
}


func downloadMovies(numberOfMovies: Int) {
    
    // Create a semaphore
    let semaphore = DispatchSemaphore(value: 1)
    
    // Run the tasks on a background thread.
    DispatchQueue.global(qos: .background).async {
        // Launch 8 tasks (8 movie downloads)
        // Each task should wait (pretend downloading takes 2 seconds) and inform the console once it's done(call signal).
        for i in 1...8 {
            semaphore.wait()
            print("launching task \(i)")
            sleep(1)
            // Let the semaphore know when you release the resource
            semaphore.signal()
        }
        
        print("Completed all resources")
    }
}

downloadMovies(numberOfMovies:2)
