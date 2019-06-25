# Concurrency And Parallelism
**Optimizing programming performance on mobile devices built with multiple cores**  
- Proccesses
- Threads
- Tasks  

## Concurrency & Parallelism
**Apps need concurrency to keep UI responsive:**    
  When you create a new app, you're working on the main thread by default. There are tasks that take longer though and
  the main thread might block it(becomes unresponsive). So, we can then run it on another thread such as the background thread.

**Concurrency-** is how we structure the app to avoid slow ui problems. Take tasks somewhere else (not on main thread). There are underlying problems though.  
**Process-** The application running it’s code on your device. It needs space and resources dependent from programs. Contains at least 1 thread(main thread) and may have more threads related. Has different address spaces(many threads under this process may share the same adress)  
**Thread-**  something that happened inside a process. Something executing. Smallest sequence that can be managed by OS(operating system) schedular.
	Each thread comes with it’s own stack space. Executes concurrently(operates at the same time) but up to the OS.   
**Task-** A quantifying work to be performed. Ex: calculate area, apply blur image, create data structure, read/write/fetch data, converting to JSON. Tasks run on threads!! All UI related tasks run on the main thread.  
**Parallelism-** Shifting from task to task. Being run at the same time. A task can be broken down into many sub tasks and all these can be processed separately AND can be completed marked done at the same time. Tasks can be broken down into smaller pieces. Can optimize performance.
	‘How we get them done’  
**Concurrency-** Compose problems into smaller units not caring about order. This allows parallelism as well which can improve execution.
	‘How we structure things’  
**Multiple Processors-**  multi cores executes multiple threads  
	Multiple cores: we spread the tasks out. Less task for each thread, and can be done at the same time.  


**Parallelism VS Concurrency:**  
Single cores can’t technically do parallelism because they don’t need to break tasks down.

**Cores on an iOS device:**
There can be many threads executing at once as there are cores in a device’s CPU (can have more threads than there are cores)

**How can we apply concurrency?:**
Splitting app into chunks of code to run faster which will improve performance.  
Tasks which are good to run simultaneously:  
	access different resources  
	only reads values from shared resources(variable)  
We can split them if it fits the options above so we wouldn’t run into crashes or wrong value if we accidentally update one part and didn’t go to update the second thread in time.  

**Concurrency is about the option to do work at the same time.(Structure)  
Parallelism is about doing work at the same time.(Execution)**

Swift and iOS provides 2 API's that can improve your apps performance:  
1. **GCD** Simply called "Dispatch"
2. **Operations** Built on top of GCD

## GCD(Grand Central Dispatch)
Optimizes application support for systems with multi core processors and other symmetric multiprocessing systems.
Comes with dispatch queues managed by the system rather than threads directly.  
The main idea for GCD is to move the management of thread pools closer toward the operating system side, instead of the developer.

- GCD uses closures to handle what's running on another thread.
- System takes cares of scheduling for you.
- Good to use for simple common tasks that need to be run only once and on the background.   

**Why use GCD?**  
	- Improves responsiveness of app
	- Simplifies the creation/execution of tasks. Can be asynchronous or synch
	- easier to use than blocks or threads

**What does GCD do?**  
	- Tasks can be run in parallel or queued up for execution
	- Abstracts the idea of threads (Dispatch Queues, work items)
	- We have less lines of code to worry about, all happens behind the scenes

**Concurrency problems:**  
	- deadlocks  
	- race conditions  
	- reader-writers problem  
	- thread explosion  

## Threads, Tasks & DispatchQueues in GCD
You work with threads by creating DispatchQueues  

**DispatchQueues**    
They manage the execution of tasks on your app's main or background thread.
- They maintain the execution of tasks either concurrently or serially
- Hides all thread management related activities
- Thread safe: can be accessed from different threads simultaneously without locking.
- Work submitted through here will work on a **thread pools**  

**Thread Pools**
Instead of creating new threads whenever a task needs to be executed, these threads are taken from a pool of available threads. (Created and managed by the Operating System)

**Tasks**
Tasks encapsulates code and data into a new object  
Light weight, easy to create and enqueue  
expressed as either a function or an anonymous block of code  

## Synchronous & Asynchronous Tasks
Different tasks can either be run syncly or asyncly  
***Synchronously:***  
	When you schedule a work item(task) synchronously, your app will wait and block the current threads run loop. Even moving it to a knew queue, it still won’t save time since sync is waiting for every task to be done to continue to the next ones.   
Conclusions: The current thread waits until the task is finished. Started on 1 thread and ***finished on the same thread***. Use this when you want to make sure one function does not get called twice. (ex. Pull to refresh where we only want it to happen once before another pull to refresh can happen, another example is when you want to fetch the data first so you can know if you want to have many different sections or not.)


***Asynchronously:***  
	Schedules task for immediate execution, and immediately returns control to the calling function. So, we don’t wait until execution finishes. The task is queued right away but also returns responsiveness to the app. Can be submitted by code on one thread but actually run on a different thread.  
Conclusions: The call in Async returns immediately ordering the task to be done but not waiting for it to be finished before continuing with other tasks. They are started on 1 thread but actually ***run on a different thread***. We use it when your app wouldn’t have to wait for the callback to be finished (ex. Filtering, networking calls, local/remote data fetching).


***What to NOT do:***  
- Never perform UI updates on any queue other than the main queue  
- Never call .sync on the current queue because this may cause a deadlock on the queue
- Never call .sync on the main queue. You never want to submit a code block synchronously against the main queue either. This can cause your app to crash or even degrade the app's performance by locking the UI.


***Deadlocks:***  
2 or more tasks which are waiting on each other to finish and get stuck in a never-ending cycle. Neither of them can proceed until the one completes, but neither can proceed, so they can never complete.

## How the Main Queue Fits
When your app is first started, it creates these 3 things:  
- ***Main Queue:*** A serial queue that's responsible for your UI. The main queue only executes code on the main thread.
- ***Main Thread:*** Allocates your app's Application object.
- ***Main Stack***

## Related Concepts to GCD
***Critical Section***  
A protected section where the shared resources are protected from concurrent(same time) access. Or else concurrent access to the same variables/resources can lead to unexpected behaviors or errors.  

***Thread Safety***  
Code can be safely called from different threads simultaneously without causing any problems. And is gauranteed to be free frorm race conditions.

## DispatchQueues
Difining Attributes:
- FIFO: First task that's added is the first task started in the queue.
- Thread Safe: All dispatch queues are thread safe.
- The decision of when to start a task is totally up to GCD


***Serial Queue***  
Guarantee that only one task runs at any given time.
- contains a single thread associated with them. Allows a single task to be executed
- Executes tasks one at a time
- There's no risk of accessing the same critical section concurrently
- The main queue is a serial queue


***Concurrent Queue***  
Can utilize as many threads as the system has resources for.
- Threads will be created and released as needed for a concurrent queue
- Multiple tasks can be run at the same time
- Tasks are started in order they were added.
- However, tasks can finish at any time and you never know when the next block is going to start. Entirely up to GCD.

## Types of Queues
The GCD library (libdispatch) Creates several queues which all have different priorities that executes tasks concurrently. And these are the 3 types of queues.  
- ***Main Queue:*** A serial queue that runs on the main thread
- ***Global Dispatch Queue:*** Concurrent queues. And there are 4 different global dispatch queues: high, default, low, background
- ***Custom Queue:*** You can create them to be either serial or concurrent queues

## QoS Priority
When setting up global dispatch queues, you need to specify the QoS level. This lets GCD know the priorrity level to give the task. And these are the 4 quality of services  
- .userInteractive
- .userInitiated
- .utility
- .background


## Operations  
- Objects that encapsulates data. And it adds a little more development overhead compared to GCD.
- You have more control over submitted tasks, scheduling through adding dependencies, can cancel/reuse/suspend them.
- Easier to do complex tasks.
- You should use operations when you need task reusability, communication between tasks, or closely monitor task execution.

***Why should we use operations?***  
- Reusability:  
Instances of subclasses of Operation classes are a "Once and done" tasks. Meaning that when an operation object is added to 1 operationQueue, it can not be added to another operationQueue.  
- Dependencies:  
Allows developers to execute tasks in a specific order. Once the last dependant operation has finished, the operation object becomes ready and able to execute.  
- KVO-compliant:  
Key value observers where we can monitor the state of an operation or operation queue.  
- Developer control:  
Gives the developer more control over the operations lifecycle such as: max number of operations(knows how many operations run at the same time), execution priority levels(you can configure the execution priority level of an operation), pause/resume/cancel.  

***How do operations work?***
- Creating operations: UYou subclass the Operation, or use one of the defined classes(NSInvocationOperation or BlockOperation)
- Executing operations: there are 2 ways to execute where we can submit to an operation queue, or we can call the start() method  

***Things to note***  
An operation can only execute its task once and can not be used to execute its task again  
Operations give us more control over number of operations and pause/resume/cancel functionality  
BlockOperations can have more than 1 block  
Easiest way to execute operations is with an operationQueue.

**Block Operations**  
It's a bridge between GCD DispatchQueues and Operations. A blockOperation can also be used to execute several blocks at once without having to create seperate operation objects for each.  
When we execute 1 operation, the operation is considered finished only when all blocks have finished executing  

**Operation's life cycle event**  
It can exist in any state: Pending -> Ready -> Executing -> Finished. Where the first 3 steps can also point to a Cancelled state.  
**Operation state properties**  
- isReady: lets client know when an operation is ready to execute
- isExecuting: once start() method is run, it passes on to this stage
- isCancelled: informs clients that a cancellation has happened.
- isFinished: lets client know that an operation has finished its task succesfully or was cancelled and is exiting.


## Common iOS questions
1. What is Concurrency?  
It is the process of how tasks run at the same time. For example, when making a networking call, whihc may take a long time to process, we'd want to separate updating the UI on a different thread.
2. What is Parallelism?  
It is when tasks run at the same time but on different threads.
3. What are most commonly used APIs to implement concurrency in iOS?  
The 2 most common ones I can think of are Operations and GCD
4. What is a queue? What is their relationship with FIFO?  
A queue is similar to the data structure where it stores the tasks within them and the tasks are getting run based on which one was added to the queue first. So they're first in first out.
5. What are all the different types of queues and their priorities?  
There are 4 priorities: userInterface, userInteractive, default, and background.  
Types of queues: Serial queue, and concurrent queue
6. What is the difference between an asynchronous and a synchronous task?  
Asynchronous tasks get run on different threads but they are run at the same time.  
Synchronous tasks run in order. SO there will never be tasks run at the same time.  
7. What is the difference between a serial and a concurrent queue?  
Serial queues doesn't allow tasks to be run simultaneously.  
Concurrent queues allows many tasks to be run on different threads and simultaneously.
8. How does GCD work?  
GCD, under the hood, contains a thread pool where the developer does not have the ability to know or state which task will be executed first. The tasks are put into a thread pool and are processed based on fifo.
9. Explain the relationship between a process, a thread and a task.
Process - Contains at least 1 thread, but can have many threads.
Thread - is something that happens inside a process
Task - a piece of work to be preformed. It gets run on threads.
10. Are there any threads running by default? Which ones?  
When we create an Xcode project, the main thread will be run by default.
11. How does iOS support multithreading?  
iOS contains GCD and operations to support multithreading.
12. What is NSOperation? and NSOperationQueue?  
NSOperation is a class where the developer has more control over the execution of the tasks and the states!  
NSOperationQueue is the queue that contains all the NSOperation objects  
13. What is QoS?  
Quality of Service - where we can explicitly state which task we want to be run first. The highest quality would be .userInitiated, and the lowest is .background.
14. Explain priority inversion.  
Priority Inversion is when a lower priority task gets run before the higher priority task is run. Where it should have been the other way round. This will cause something called race conditions.
15. Explain dependencies in Operations  
If an operation depends on another operation, the depending operation must finish executing first before the current operation gets run.
16. When do you use GCD vs Operations?
Use operations if you want to have more control over tasks and the order they get run. Use GCD's for ease of use because it handles the tasks and order of run by itself.
17. How do we know if we have a race condition?  
We will have a race condition if the variables getting accessed are incorrect.
18. What is deadlock?  
A deadlock is when 2 threads want access to the same resource but they are constantly waiting for each other so no thread ever gets what they want.
19. What is context switching in multithreading?  
Context switching is the process of changing threads to run other tasks first and then coming back to the same thread to run the current task. This can happen continuously.
20. What are the ways we can execute an Operation? How are they different?  
We can execute an operation by creating an instance of an operation and then either putting it in a queue, or calling .start method on it.
21. What is DispatchSemaphore and when can we use it?  
DispatchSemaphore is a class where we can create a semaphore and run different tasks on it.
22. What happens if you call sync() on the current or main queue?  
It can cause the app to crash because calling synch on the main thread will stop all tasks that are currently running. 





## Class Work / Projects
[Thread Playground](https://github.com/SarinSwift/MOB2.3-ConcurrencyAndParallelism/tree/master/Threads.playground)  
[GCD Playground](https://github.com/SarinSwift/MOB2.3-ConcurrencyAndParallelism/tree/master/GCDPlay.playground)  
[QualityofService exercise on 2 queues](https://github.com/SarinSwift/MOB2.3-ConcurrencyAndParallelism/tree/master/QoS_exercise1.playground)  
[QualityofService exercise on 2 queues + main queue](https://github.com/SarinSwift/MOB2.3-ConcurrencyAndParallelism/tree/master/QoS_ex2.playground)  
[Working with DispatchGroups](https://github.com/SarinSwift/MOB2.3-ConcurrencyAndParallelism/tree/master/DispatchGroups_ex1.playground)  
