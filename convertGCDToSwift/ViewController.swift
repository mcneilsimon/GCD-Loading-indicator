//
//  ViewController.swift
//  convertGCDToSwift
//
//  Created by Kate Wong on 2017-08-02.
//  Copyright © 2017 Individual. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var downloadCompleted: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    var refToQueueOperation: DispatchQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //thread execution starts
    @IBAction func actionButton(_ sender: UIButton) {
        refToQueueOperation = DispatchQueue(label: "queue")

        refToQueueOperation?.async(execute: {() -> Void in
            self.longRunningOperation()
        })
        
    }
    //loops the progress bar until completed
    func longRunningOperation(){
        for i in 0..<101 {
            self.performUpdate(i) {
                Thread.sleep(forTimeInterval: 0.1)
            }
        }
    }
    
    //thread execution begings
    func performUpdate(_ index: Int, selector: @escaping () -> ()) {

        DispatchQueue.main.async(execute: {() -> Void in
            
            self.downloadCompleted.text = ""
            
            //once index value is greater then 10, then the download will be completed
            if (index >= 100) {
                self.downloadButton.isEnabled = true
                self.downloadButton.alpha = 1.0
                self.result.text = "100%"
                self.downloadCompleted.text = "Download Completed!"
                self.progressBar.progress=0
            }
            else{
                self.downloadButton.isEnabled = false
                self.downloadButton.alpha = 0.25
                let progressResults = Float(index) / 100.0
                let loadingActivity = index != 0
                self.progressBar.setProgress(progressResults, animated: loadingActivity)
                self.result.text = ("\(index)%")
            }
        })
        selector()
    }
}











