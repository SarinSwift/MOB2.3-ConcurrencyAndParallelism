//
//  ForkPair.swift
//  DIningPhilosophers
//
//  Created by Sarin Swift on 6/22/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation

// used for holding an array of DispatchSemaphore
struct ForkPair {
    static var philosophersDispatchArray = Array(repeating: DispatchSemaphore(value: 1), count: 4)  // 4 philosophers
    
    var leftFork: DispatchSemaphore
    var rightFork: DispatchSemaphore
    
    init(leftIndex: Int, rightIndex: Int) {
        //Order forks by index to prevent deadlock
        if leftIndex > rightIndex {
            leftFork = ForkPair.philosophersDispatchArray[leftIndex]
            rightFork = ForkPair.philosophersDispatchArray[rightIndex]
        } else {
            leftFork = ForkPair.philosophersDispatchArray[rightIndex]
            rightFork = ForkPair.philosophersDispatchArray[leftIndex]
        }
    }
    
    func pickup() {
        // start with the lower index
        leftFork.wait()
        rightFork.wait()
    }
    
    func putDown() {
        // once done, we need signal that it's done used
        leftFork.signal()
        rightFork.signal()
    }
}
