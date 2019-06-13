import UIKit

// The following BO(BlockOperation) is made up of multiple code blocks, and is started by the OperationQueue

// 1) create printerOperation as BlockOperation object
let printerOperation = BlockOperation()

// 2) add code blocks to the operation which will be parts of the operation
printerOperation.addExecutionBlock { print("I") }
printerOperation.addExecutionBlock { print("am") }
printerOperation.addExecutionBlock { print("printing") }
printerOperation.addExecutionBlock { print("block") }
printerOperation.addExecutionBlock { print("operation") }

// 3) set completion block
printerOperation.completionBlock = {
    print("I'm done printing")
}

// 4) Create an OperationQueue that will call start on our operation object
let operationQueue = OperationQueue()
// 5) add operation to queue
operationQueue.addOperation(printerOperation)
