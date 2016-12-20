//
//  ListaFilmesTableViewController.swift
//  cine_ufes
//
//  Created by Student on 12/19/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import UIKit

class ListaFilmesTableViewController: UITableViewController {

    var filmes = [Titulo]()
    
    let prog1 = Evento(dia:"Segunda", hora:"19", data:"2010-09-20")
    let prog2 = Evento(dia:"Terca", hora:"15", data:"2010-09-21")
    let prog3 = Evento(dia:"Quarta", hora:"13", data:"2010-09-22")
    let prog4 = Evento(dia:"Quinta", hora:"17", data:"2010-09-23")
    let prog5 = Evento(dia:"Sexta", hora:"20", data:"2010-09-24")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var listProg = [Evento]()
        listProg.append(prog1)
        listProg.append(prog2)
        
        let f1 = Titulo(nome:"Harry Potter",genero: "Bosta", imagem:"HP", nota:1.0, tipo:"f",sinopse:"Filme de uma franquia que começou bem, mas ficou uma bosta", programacao:listProg)
        
        filmes.append(f1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filmes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Titulo", forIndexPath: indexPath) as! TituloTableViewCell

        cell.TituloLabel.text = self.filmes[indexPath.row].nome
        cell.generoLabel.text = self.filmes[indexPath.row].genero
        cell.notaLabel.text = String(self.filmes[indexPath.row].nota)
        cell.imageView!.image = UIImage(named:self.filmes[indexPath.row].imagem!)
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}