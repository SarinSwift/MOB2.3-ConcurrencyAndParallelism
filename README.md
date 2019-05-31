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
***Asynchronously:***  
	Schedules task for immediate execution, and immediately returns control to the calling function. So, we don’t wait until execution finishes. The task is queued right away but also returns responsiveness to the app. Can be submitted by code on one thread but actually run on a different thread.


	
## Operations  
- Objects that encapsulates data. And it adds a little more development overhead compared to GCD.
- You have more control over submitted tasks, scheduling through adding dependencies, can cancel/reuse/suspend them.
- Easier to do complex tasks.
- You should use operations when you need task reusability, communication between tasks, or closely monitor task execution.

		
## Class Work / Projects
[Thread Playground](https://github.com/SarinSwift/MOB2.3-ConcurrencyAndParallelism/tree/master/Threads.playground)  
[GCD Playground](https://github.com/SarinSwift/MOB2.3-ConcurrencyAndParallelism/tree/master/GCDPlay.playground)
