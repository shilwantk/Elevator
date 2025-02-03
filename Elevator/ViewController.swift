//
//  ViewController.swift
//  Elevator
//
//  Created by KirtiS on 1/28/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let elevator = Elevator(maxFloors: 15)
        elevator.request(stop: ElevatorStop(startFloor: 5, endFloor: 7))
        elevator.request(stop: ElevatorStop(startFloor: 1, endFloor: 2))
        elevator.request(stop: ElevatorStop(startFloor: 4, endFloor: 2))
        elevator.request(stop: ElevatorStop(startFloor: 7, endFloor: 9))
        elevator.request(stop: ElevatorStop(startFloor: 3, endFloor: 2))
        elevator.move()
    }
}

