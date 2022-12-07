//
//  CalenderUtil.swift
//  echoApp
//
//  Created by Torger Bocianowski on 07/12/2022.
//

import SwiftUI
import EventKit
import EventKitUI
import UIKit

class CalendarUtil: UIViewController, EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    let eventStore = EKEventStore()
    var time = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
           DispatchQueue.main.async {
               if (granted) && (error == nil) {
                   let event = EKEvent(eventStore: self.eventStore)
                   event.title = "Keynote Apple"
                   event.startDate = self.time
                   event.url = URL(string: "https://apple.com")
                   event.endDate = self.time
                   let eventController = EKEventEditViewController()
                   eventController.event = event
                   eventController.eventStore = self.eventStore
                   eventController.editViewDelegate = self
                   self.present(eventController, animated: true, completion: nil)
                   
               }
           }
       })
    }
}
