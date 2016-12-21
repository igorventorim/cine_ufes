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
//    
//    let prog1 = Evento(dia:"Segunda", hora:"19", data:"2010-09-20")
//    let prog2 = Evento(dia:"Terca", hora:"15", data:"2010-09-21")
//    let prog3 = Evento(dia:"Quarta", hora:"13", data:"2010-09-22")
//    let prog4 = Evento(dia:"Quinta", hora:"17", data:"2010-09-23")
//    let prog5 = Evento(dia:"Sexta", hora:"20", data:"2010-09-24")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFilmes()
        

        //var listProg = [Evento]()
//        listProg.append(prog1)
//        listProg.append(prog2)
        
//        let f1 = Titulo(nome:"Harry Potter",genero: "Bosta", imagem:"HP", nota:1.0, tipo:"f",sinopse:"Filme de uma franquia que começou bem, mas ficou uma bosta", programacao:listProg)
        
//        filmes.append(f1)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Titulo", forIndexPath: indexPath) as! FilmesTableViewCell

        cell.tituloLabel.text = self.filmes[indexPath.row].nome
        cell.generoLabel.text = self.filmes[indexPath.row].genero
        cell.notaLabel.text = String(self.filmes[indexPath.row].nota!)
        
        
        if let url = NSURL(string:self.filmes[indexPath.row].imagem!) {
            
            if let data = NSData(contentsOfURL: url){
                
                cell.imagemView.image = UIImage(data:data)
            }
        }
        
        cell.layer.borderWidth = 1.5
        cell.layer.cornerRadius = 1
        
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.clipsToBounds = true
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "myId" {
            if let filmesVC = segue.destinationViewController as? FilmesViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let filmeSelecionado = filmes[indexPath.row]
                    
                    filmesVC.titulo = filmeSelecionado
                }
            }
        }
        
    }
    
    func getFilmes()
    {
        let scriptUrl = "http://minhaopiniao.pe.hu/cine_ufes_service.php"
        let urlWithParams = scriptUrl + "?action=getTitulos"
        let myUrl = NSURL(string: urlWithParams);
        let request = NSMutableURLRequest(URL:myUrl!);
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        {
            
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            // Print out response string
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            
            // Convert server json response to NSDictionary
            do {
                
                if let convertedJsonIntoArray:NSArray = try NSJSONSerialization.JSONObjectWithData(data!,options: NSJSONReadingOptions.AllowFragments) as? NSArray{
                    
                    for json in convertedJsonIntoArray
                    {
                        let titulo = Titulo()
                        
                        if let nome = json["nome"] as? String {titulo.nome = nome}
                        
                        if let genero = json["genero"] as? String {titulo.genero = genero}
                        
                        if let id = json["_ID"] as? String{ titulo.idTitulo = Int(id)!}
                        
                        if let img = json["imagem"] as? String{ titulo.imagem = img}
                        
                        if let nota = json["nota"] as? String{ titulo.nota = Double(nota)}
                        
                        if let sinopse = json["sinopse"] as? String{ titulo.sinopse = sinopse }
                        
                        if let tipo = json["tipo"] as? String{ titulo.tipo = Character(tipo)}

                        if(titulo.tipo == "f")
                        {
                            self.filmes.append(titulo)
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }

}
