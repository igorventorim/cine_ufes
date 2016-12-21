//
//  FilmesViewController.swift
//  cine_ufes
//
//  Created by Student on 12/21/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import UIKit

class FilmesViewController: UIViewController {
    
    @IBOutlet weak var imagemView: UIImageView!

    @IBOutlet weak var tituloLabel: UILabel!
    var titulo: Titulo?
    
    @IBOutlet weak var sinopseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tituloLabel.text = titulo?.nome
        sinopseLabel.text = titulo?.sinopse
        if let url = NSURL(string:(titulo?.imagem)!) {
            
            if let data = NSData(contentsOfURL: url){
                
                imagemView!.image = UIImage(data:data)
            }
        }
        
        
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
    
}









