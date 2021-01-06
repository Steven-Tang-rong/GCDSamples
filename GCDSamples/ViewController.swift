//
//  ViewController.swift
//  GCDSamples
//
//  Created by Gabriel Theodoropoulos on 07/11/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var inactiveQueue: DispatchQueue!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // simpleQueues()
        
        // queuesWithQoS()
        
        
        //concurrentQueues()
//        if let queue = inactiveQueue {
//            queue.activate()
//        }
        
        //延遲執行
        //queueWithDelay()
        
        //fetchImage()
        
        useWorkItem()
    }
    
    
    
    func simpleQueues() {
        let queueSteven = DispatchQueue(label: "steven.myqueue")
        queueSteven.async {
            for i in 1..<10 {
                print("💡", i)
            }
        }
        //main Queue
        for i in 100..<110 {
            print("🎁", i)
        }
    }
    
    
    func queuesWithQoS() {
        let queueOne = DispatchQueue(label: "myQueue1", qos: DispatchQoS.userInitiated)
        let queueTwo = DispatchQueue(label: "myQueue2", qos: DispatchQoS.utility)
        
        queueOne.async {
            for i in 1..<10 {
                print("🎈", i)
            }
        }
        
        queueTwo.async {
            for i in 100..<109 {
                print("💧", i)
            }
        }
        
        for M in 2012..<2021 {
            print("♏️", M)
        }

    }
    
    
    func concurrentQueues() {
        let anotherQueue = DispatchQueue(label: "myConcurrentQueue", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive])
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 1..<10 {
                print("❤️", i)
            }
        }
        
        anotherQueue.async {
            for i in 100..<110 {
                print("💙", i)
            }
        }
        
        anotherQueue.async {
            for i in 1000..<1010 {
                print("💜", i)
            }
        }
    }
    
    
    func queueWithDelay() {
        let delayQueue = DispatchQueue(label: "myDelayQueue", qos: .userInitiated)
        let addtionaltime : DispatchTimeInterval = .seconds(6)
        print(Date())
        
        delayQueue.asyncAfter(deadline: .now() + addtionaltime) {
            print(Date())
        }
    }
    
    
    func fetchImage() {
        let imageURL = URL(string: "https://www.appcoda.com.tw/wp-content/uploads/2015/07/appcoda_new_logo_400.png")!
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            if let data = imageData {
                print("Did download image data")
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
    
    
    func useWorkItem() {
        var value = 10
        
        let workItem = DispatchWorkItem {
            value += 5
        }
        
        workItem.perform()
        
        let queue = DispatchQueue.global()
        queue.async(execute: workItem)
//        queue.async {
//            workItem.perform()
//        }
        
        workItem.notify(queue: DispatchQueue.main) {
            print("Value = ", value)
        }
        
    }
}

