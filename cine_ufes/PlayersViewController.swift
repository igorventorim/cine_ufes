//
//  PlayersViewController.swift
//  cine_ufes
//
//  Created by Student on 19/12/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func imageForRating(rating:Int) -> UIImage? {
        let estrelinhas = "\(rating)Stars"
        return UIImage(named: estrelinhas)
    }

}
