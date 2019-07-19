//
//  EventTableViewController.swift
//  SEAC_Project_Experimentation
//
//  Created by Student on 7/17/19.
//  Copyright © 2019 SEAC_Organization. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventTableViewController: UITableViewController {
    
    struct Event {
        var name: String
        var loc: String
        var date: Date
        var dateString: String
        var time: String
        var people: String
        var img: UIImage
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var events : [Event] = []
    var eventKey:String?
    var eventInfo = [String]()
    var databaseHandler:DatabaseHandle?
    var databaseHandler2:DatabaseHandle?
    let ref = Database.database().reference()
    var eventNames = [String]()
    var eventLocations = [String]()
    var eventTimes = [String]()
    var eventDays = [String]()
    var eventPeoples = [String]()
    var eventImgs = [UIImage]()
    var eventGroups = [String]()
    var count = 0
    
    let dateFormatterPrim = DateFormatter()
    let wordToRemove = "Event "
    let wordToRemove2 = "Optional("
    let errorMessage = "Error in ETVC class!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenHeightFloat:Float = Float(screenHeight)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //loadSampleEvents()
        //loadEvents()
        self.tableView.rowHeight = (screenHeight/5) - CGFloat((screenHeightFloat * 0.011))
        self.tableView.alwaysBounceVertical = false
        self.tableView.allowsSelection = false
        
        databaseHandler = ref.child("events").observe(.childAdded, with: { (snapshot) in
            self.eventKey = snapshot.key
            
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                //print(child.value)
                var word = child.value as? String
                if let range = word?.range(of: self.wordToRemove2) {
                    word?.removeSubrange(range)
                    word?.removeLast()
                }
                //self.eventInfo.append(word!)
                //print(self.eventInfo)
                //print(self.count)
                if self.count < 5 {
                    switch (self.count){
                    case 0:
                        self.eventDays.append(word!)
                        
                    case 1:
                        self.eventGroups.append(word!)
                        if word == "SEAC" {
                            self.eventImgs.append(UIImage(named: "main-logo.png")!)
                        }
                        else if word == "WYND" {
                            self.eventImgs.append(UIImage(named: "stock-img")!)
                        }
                        else {
                            self.eventImgs.append(UIImage(named: "stock-img")!)
                        }
                        
                    case 2:
                        self.eventLocations.append(word!)
                        
                    case 3:
                        self.eventNames.append(word!)
                        
                    case 4:
                        self.eventPeoples.append(word!)
                        
                    case 5:
                        self.eventTimes.append(word!)
                        
                    default:
                        print("Something went wrong with the switch statement!")
                    }
                    self.count += 1
                }
                else if self.count == 5 {
                    self.eventTimes.append(word!)
                    self.count = 0
                }
                
            }
            /*
            self.databaseHandler2 = self.ref.child("events").child(snapshot.key).observe(.childAdded, with: { (snapshotChild) in
                let eventN = snapshotChild.childSnapshot(forPath: "event-name").value as? String
                let eventD = snapshotChild.childSnapshot(forPath: "event-day").value as? String
                let eventG = snapshotChild.childSnapshot(forPath: "event-group").value as? String
                let eventL = snapshotChild.childSnapshot(forPath: "event-location").value as? String
                let eventP = snapshotChild.childSnapshot(forPath: "event-people").value as? String
                let eventT = snapshotChild.childSnapshot(forPath: "event-time").value as? String
                
                self.eventNames.append(eventN ?? self.errorMessage)
                self.eventLocations.append(eventL ?? self.errorMessage)
                self.eventDays.append(eventD ?? self.errorMessage)
                self.eventTimes.append(eventT ?? self.errorMessage)
                self.eventPeoples.append(eventP ?? self.errorMessage)
                self.eventGroups.append(eventG ?? self.errorMessage)
                
                self.eventImgs.append(UIImage(imageLiteralResourceName: "main-logo.png"))
                /*if eventG == "SEAC" {
                    self.eventImgs.append(UIImage(named: "main-logo.png")!)
                }
                else if eventG == "WYND" {
                    self.eventImgs.append(UIImage(named: "stock-img")!)
                }
                else if eventG == "Special" {
                    self.eventImgs.append(UIImage(named: "stock-img")!)
                }*/
                print("b")
                self.tableView.reloadData()
            })*/
            self.tableView.reloadData()
        })
    }
        
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EventCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else {
            fatalError("Dequeued Cell didn't work ... Good luck!")
        }
        // Configure the cell...
        print(eventNames.count)
        print(eventImgs.count)
        print(eventGroups.count)
        print(eventLocations.count)
        print(eventDays.count)
        print(eventTimes.count)
        
        cell.eventName.text = eventNames[indexPath.row]
        cell.eventImg.image = eventImgs[indexPath.row]
        cell.eventPeople.text = eventPeoples[indexPath.row] + " " + eventGroups[indexPath.row]
        cell.eventLocAndTime.text = "The performance is at " + eventLocations[indexPath.row] + " on " + eventDays[indexPath.row] + " at " + eventTimes[indexPath.row]
        print("a")
        return cell
    }
    /*override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }*/
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    /*private func loadSampleEvents() {
        guard let seacPhoto = UIImage(named: "main-logo.png") else { return }
        guard let wyndPhoto = UIImage(named: "stock-img") else { return }
        
        let event1 = Event(name: "Event Name: Sample 1", locAndTime: "Location + Time: Sample 1", people: "Youth Needed: Sample 1", img: seacPhoto)
        let event2 = Event(name: "Event Name: Sample 2", locAndTime: "Location + Time: Sample 2", people: "Youth Needed: Sample 2", img: wyndPhoto)
        let event3 = Event(name: "Event Name: Sample 3", locAndTime: "Location + Time: Sample 3", people: "Youth Needed: Sample 3", img: seacPhoto)
        let event4 = Event(name: "Event Name: Sample 4", locAndTime: "Location + Time: Sample 4", people: "Youth Needed: Sample 4", img: wyndPhoto)
        let event5 = Event(name: "Event Name: Sample 5", locAndTime: "Location + Time: Sample 5", people: "Youth Needed: Sample 5", img: seacPhoto)
        
        events += [event1, event2, event3, event4, event5]
    }*/
    public func addEvent(event: Event) {
        events.append(event)
        events = orderEvents(events: events)
    }
    
    func orderEvents(events: [Event]) -> [Event] {
        let newEvents = events
        if newEvents.count == 1 {
            return newEvents
        }
        print("e")
        return newEvents.sorted(by: { $0.date > $1.date })
    }
    
    func makeNewEvent(name: String, loc: String, date: Date, dateString: String, time: String, people:String, img: UIImage) {
        
        let newEvent = Event(name: name, loc: loc, date: date, dateString: dateString, time: time, people: people, img: img)
        
        events.append(newEvent)
    }
}
