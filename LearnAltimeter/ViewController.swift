//
//  ViewController.swift
//  LearnAltimeter
//
//  Created by Ivan Sebastian on 08/07/19.
//  Copyright © 2019 Vanski Corp. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var ClimbedLabel: UILabel!
    @IBOutlet weak var altimeterLabel: UILabel!
    

    let altimeter = CMAltimeter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startAltitudeTracking()
        
    }

    func startAltitudeTracking()
    {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            //TODO: Show error alert
            print("Error")
            return
        }
        
        let queue = OperationQueue()
        queue.qualityOfService = .background
        
        altimeter.startRelativeAltitudeUpdates(to: queue) { (altimeterData, error) in
            if let altimerData = altimeterData {
                DispatchQueue.main.async {
                let relativeAltitude = altimeterData?.relativeAltitude as! Double
                    
                
                    let roundedAltitude         = Int(relativeAltitude.rounded(toDecimalPlaces: 0))
                    self.altimeterLabel.text = "\(roundedAltitude)m"
                }
            }
        }
        
    }

}




extension Double {
    
    func rounded(toDecimalPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


