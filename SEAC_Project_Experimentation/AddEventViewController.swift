//
//  AddEventViewController.swift
//  SEAC_Project_Experimentation
//
//  Created by Student on 7/17/19.
//  Copyright © 2019 SEAC_Organization. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventLocAndTime: UITextField!
    @IBOutlet weak var eventPeople: UITextField!
    @IBOutlet weak var eventGroup: UISegmentedControl!
    @IBOutlet weak var accessCode: UITextField!
    var count: Int = 0
    var image: UIImage = UIImage(imageLiteralResourceName: "stock-img")
    
    let dateFormatterPrim = DateFormatter()
    
    var accessCodes = [102901, 1029302]
    
    /*struct Event {
        var name: String
        var loc: String
        var date: Date
        var dateString: String
        var time: String
        var people: String
        var img: UIImage
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setPlaceholder()
    }
    
    /*func setPlaceholder() -> Event {
        let placeHolderImage = UIImage(named: "stock-img")!
        let date = Date()
        let placeHolderEvent = Event(name: "", loc: "", date: date, dateString: "", time: "", people: "", img: placeHolderImage)
        
        return placeHolderEvent
    }*/
    
    @IBAction func addEvent(_ sender: Any) {
        dateFormatterPrim.dateFormat = "MM/dd"
        let accessCodeInput = Int(accessCode.text ?? "Error")
        let dayAndTime = eventLocAndTime.text!
        let newDayAndTime = dayAndTime.suffix(14)
        var time = newDayAndTime.suffix(5)
        var day = newDayAndTime.prefix(6)
        let removal: Set<Character> = ["0", " "]
        let removal2: Set<Character> = [" "]
        var dataMass = eventLocAndTime.text!
        dataMass.removeLast(14)
        var location = dataMass
        location.removeLast()
        //let date = dateFormatterPrim.date(from: String(day))!
        time.removeAll(where: {removal2.contains($0)})
        day.removeAll(where: {removal.contains($0)})
        
        print("a")
        if accessCodeInput == accessCodes[0] || accessCodeInput == accessCodes[1] {
            var group: String
            count += 1
            switch eventGroup.selectedSegmentIndex {
            case 0:
                group = "WYND"
                image = UIImage(imageLiteralResourceName: "stock-img")
                break
            case 1:
                group = "SEAC"
                image = UIImage(imageLiteralResourceName: "main-logo.png")
                break
            case 2:
                group = "Special"
                image = UIImage(imageLiteralResourceName: "stock-img")
                break
            default:
                group = "Nil"
            }
            print("b")
            let value = ["Event \(String(eventName.text!))": count]
            let values = ["event-name": eventName.text as Any, "event-location": location as Any, "event-time": time as Any, "event-people": eventPeople.text as Any, "event-group": group, "event-day": day] as [String : Any]
            Database.database().reference().child("events").updateChildValues(value as [AnyHashable : Any])
            Database.database().reference().child("events").child("Event \(String( eventName.text!))").updateChildValues(values as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to update database values, ", error.localizedDescription)
                    return
                }
            })
            print("c")
            //EventTableViewController().makeNewEvent(name: eventName.text!, loc: location, date: date, dateString: String(day), time: String(time), people: eventPeople.text!, img: image)
        }
    }
    
    /*func makeNewEvent(name: String, loc: String, date: Date, dateString: String, time: String, people:String, img: UIImage) -> Event {
        
        let newEvent = Event(name: name, loc: loc, date: date, dateString: dateString, time: time, people: people, img: img)
        
        return newEvent
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
