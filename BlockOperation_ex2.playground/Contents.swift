import Foundation

let phrase = "Mobile is the greatest!"
let tokenOperation = BlockOperation()

for token in phrase.split(separator: " ") {
    tokenOperation.addExecutionBlock {
        print(token)
        sleep(2)
    }
}

// create completionBlock (this will run at the end because this one runs once every operation has done executing)
tokenOperation.completionBlock = {
    print("All operations completed!")
}

duration {
    // start the operation
    tokenOperation.start()
}
