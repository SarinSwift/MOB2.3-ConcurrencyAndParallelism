//
//  ViewController.swift
//  DIningPhilosophers
//
//  Created by Sarin Swift on 6/14/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit
import Dispatch

// The dining philosophers problem Algorithm implemented in Swift (concurrent algorithm design to illustrate synchronization issues and techniques for resolving them using GCD and Semaphore in Swift)

class ViewController: UIViewController {

    static let numberOfPhilosophers = 4
    let globalSem = DispatchSemaphore(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simulation()
        
        for semaphore in ForkPair.philosophersDispatchArray {
            // start the thread signaling the semaphore
            semaphore.signal()
        }
        
        // wait forever
        globalSem.wait()
    }

    // Creating the simulation
    
    // Layout of the table (P = philosopher, f = fork) for 4 Philosophers
    //          P0
    //       f3    f0
    //     P3        P1
    //       f2    f1
    //          P2
    
    
    func simulation() {
        for i in 0..<ViewController.numberOfPhilosophers {
            DispatchQueue.global(qos: .background).async {
                let p = Philosopher(philosopherIndex: i)
                
                p.run()
            }
        }
    }
    
}


