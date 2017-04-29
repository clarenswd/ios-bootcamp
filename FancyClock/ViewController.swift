//
//  ViewController.swift
//  FancyClock
//
//  Created by clearence wissar on 29/4/17.
//  Copyright © 2017 ClearenceWissar. All rights reserved.
//

import UIKit


extension Date {
    
    /// Returns a Date with the specified days added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: self)!
        targetDay = Calendar.current.date(byAdding: .month, value: months, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .hour, value: hours, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .minute, value: minutes, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .second, value: seconds, to: targetDay)!
        return targetDay
    }
    
    /// Returns a Date with the specified days subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let inverseYears = -1 * years
        let inverseMonths = -1 * months
        let inverseDays = -1 * days
        let inverseHours = -1 * hours
        let inverseMinutes = -1 * minutes
        let inverseSeconds = -1 * seconds
        return add(years: inverseYears, months: inverseMonths, days: inverseDays, hours: inverseHours, minutes: inverseMinutes, seconds: inverseSeconds)
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var dateFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    //http://stackoverflow.com/questions/5067785/how-do-i-add-1-day-to-a-nsdate
    func dateByAddingDays(inDays:NSInteger)->Date{
        let today = Date()
        return Calendar.current.date(byAdding: .day, value: inDays, to: today)!
    }
    var today = Date() // date is then today for this example
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
     
        timeFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium

        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let tomorrow = self.today.add(days: 1)
//            self.dateLabel.text = self.dateFormatter.string(from: Date())
            self.dateLabel.text = self.dateFormatter.string(from: tomorrow)
            self.today = tomorrow
            self.timeLabel.text = self.timeFormatter.string(from: Date())
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

