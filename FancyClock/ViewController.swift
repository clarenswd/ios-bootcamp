//
//  ViewController.swift
//  FancyClock
//
//  Created by clearence wissar on 29/4/17.
//  Copyright © 2017 ClearenceWissar. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var dateFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.dateLabel.text = self.dateFormatter.string(from: Date())
            self.timeLabel.text = self.timeFormatter.string(from: Date())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

