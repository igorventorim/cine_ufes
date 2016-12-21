//
//  ListaTeatroTableViewController.swift
//  cine_ufes
//
//  Created by Student on 12/20/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import UIKit

class ListaTeatroTableViewController: UITableViewController {

    
    var teatro = [Titulo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTeatro()
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
        return teatro.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Titulo", forIndexPath: indexPath) as! TeatroTableViewCell
        
        cell.tituloLabel.text = self.teatro[indexPath.row].nome
        cell.generoLabel.text = self.teatro[indexPath.row].genero
        cell.notaLabel.text = String(self.teatro[indexPath.row].nota!)
        
        if let url = NSURL(string:self.teatro[indexPath.row].imagem!) {
            
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "myId" {
            if let teatroVC = segue.destinationViewController as? FilmesViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let teatroSelecionado = teatro[indexPath.row]
                    
                    teatroVC.titulo = teatroSelecionado
                }
            }
        }
        
    }
    
  
    func getTeatro()
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
                        
                        if(titulo.tipo == "t")
                        {
                            self.teatro.append(titulo)
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
