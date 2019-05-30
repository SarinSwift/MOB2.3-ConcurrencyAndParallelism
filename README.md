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

## GCD(Grand Central Dispatch)
Optimizes application support for systems with multi core processors and other symmetric multiprocessing systems.
Comes with dispatch queues managed by the system rather than threads directly. 

**Concurrency problems:**  
	deadlocks
	race conditions
	reader-writers problem
	thread explosion
		
## Class Work / Projects
[Thread Playground](https://github.com/SarinSwift/MOB2.3-ConcurrencyAndParallelism/tree/master/Threads.playground)

