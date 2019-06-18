import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true




// Queue
let operationQueue = OperationQueue()
operationQueue.qualityOfService = .userInitiated

class MyOperation: Operation {
    
    // 1. Create main()
    // we need to call this function because we are creating a non concurrent operation
    override func main() {
        print("MyOp Started")
        // whatever we want to get done which is a long running task.
    }
}

let myOp = MyOperation()

myOp.completionBlock = {
    print("MyOp Completed")
}

// How you add an operation to an operation queue
operationQueue.addOperation(myOp)
