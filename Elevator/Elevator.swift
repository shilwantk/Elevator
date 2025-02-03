//
//  Elevator.swift
//  Elevator
//
//  Created by KirtiS on 1/28/25.
//

import Foundation

///Enum denoting Elevator State at any given movement
enum ElevatorState {
    case movingDown, movingUp, idle
}

///Struct for a Elevator Stop, that takes two Ints, one for the Start Floor and the Second for the End Floor
struct ElevatorStop {
    var startFloor: Int
    var endFloor : Int
}

///Elevator class that manages stop requests and elevator movement
class Elevator {
    
    ///Property of type Int to determine the maximum number of floors the elevator can serve
    var maxFloors : Int
    
    ///Property of  type Int to store the current floor, default value is 0
    var currentFloor: Int = 0
    
    ///Property of type ElevatorState to store the current state of the elevator, default value isIdle
    var currentState: ElevatorState = .idle
    
    ///2 queues to store stop requests.
    ///Up Queue handles all requests for going up when idle
    var upQueue: [ElevatorStop] = []
    ///Down Queue handles all requests for going down when idle
    var downQueue : [ElevatorStop] = []
    
    init(maxFloors: Int) {
        self.maxFloors = maxFloors
    }
    
    
    ///Function to process a request for an elevator stop
    /// - Parameter stop: Argument of type Elevator Stop, that denotes request to be added.
    func request(stop: ElevatorStop) {
        
        ///Check if either start or end floor is higher than the max floor
        if stop.startFloor > 15 || stop.endFloor > 15 {
            fatalError("Elevator can only serve a maximum of \(maxFloors) floors")
        }
        sortRequest(stop: stop)
    }
    
    /// Function to sort the requests in up or down queue, and then sorting them respectively.
    /// Up queue will have all requests in ascending order, down queue will have all requests in descending order.
    /// - Parameter stop: Argument of type Elevator Stop
    func sortRequest(stop: ElevatorStop) {
        if stop.startFloor > stop.endFloor {
            downQueue.append(stop)
            downQueue.sort { $0.startFloor > $1.startFloor }
        } else {
            upQueue.append(stop)
            upQueue.sort { $0.startFloor < $1.startFloor }
        }
    }
    
    /// Function to move the elevator
    /// Processes all the requests on the Up queue first.
    /// Once the Up queue is complete, processes all the Down queue requests
    /// Once the Down queue is complete, processes all the requests in the waiting queue and sorts them in the respective queues
    func move() {
        while !upQueue.isEmpty {
            currentState = .movingUp
            processQueue(queue: &upQueue)
        }
        while !downQueue.isEmpty {
            currentState = .movingDown
            processQueue(queue: &downQueue)
        }
        currentState = .idle
    }
    
    /// Function to set the current floor to the next floor based ob the elevator movement
    /// Also clears the passed in queue as each request is processed.
    /// - Parameter queue: Inout parameter of type  [Elevator Stop]
    func processQueue(queue: inout [ElevatorStop]) {
        let nextFloor = queue.first!.startFloor
        print("Elevator is on floor \(currentFloor)")
        print("Elevator is moving to floor \(nextFloor)")
        print("Elevator is moving from \(nextFloor) to \(queue.first!.endFloor)")
        currentFloor = nextFloor
        queue.removeFirst()
    }
}
