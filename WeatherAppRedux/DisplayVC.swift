//
//  DisplayVC.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 12/4/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class DisplayVC: UIViewController {

    @IBOutlet weak var testLbl: UILabel!
    
    var test = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLbl.text = test
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
