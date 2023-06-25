//
//  Scheduler.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Combine
import Foundation

/// The `Scheduler` class provides static properties representing schedulers for performing tasks on different execution contexts.
final class Scheduler {
    
    /// The background work scheduler used for concurrent operations.
       /// The scheduler utilizes an `OperationQueue` with a maximum concurrent operation count of 5.
       /// It is designed for tasks that can be executed concurrently.
       static var backgroundWorkScheduler: OperationQueue = {
           let operationQueue = OperationQueue()
           operationQueue.maxConcurrentOperationCount = 5
           operationQueue.qualityOfService = QualityOfService.userInitiated
           return operationQueue
       }()

       /// The main scheduler representing the main thread's run loop.
       /// It is used for performing tasks on the main thread, such as UI updates.
       static let mainScheduler = RunLoop.main
}
