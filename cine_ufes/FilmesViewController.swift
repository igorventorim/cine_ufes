//
//  FilmesViewController.swift
//  cine_ufes
//
//  Created by Student on 12/21/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import UIKit

class FilmesViewController: UIViewController, UITableViewDataSource{
    
    var listEvent = [Evento]()
    
    @IBOutlet weak var programacaoTableView: UITableView!
    
    @IBOutlet weak var imagemView: UIImageView!

    @IBOutlet weak var tituloLabel: UILabel!
    var titulo: Titulo?
    
    @IBOutlet weak var sinopseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEventos((titulo?.idTitulo)!)
        
        tituloLabel.text = titulo?.nome
        sinopseLabel.text = titulo?.sinopse
        if let url = NSURL(string:(titulo?.imagem)!) {
            
            if let data = NSData(contentsOfURL: url){
                
                imagemView!.image = UIImage(data:data)
            }
        }
        
        programacaoTableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listEvent.count
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("list", forIndexPath: indexPath) as! ProgramacaoCellTableViewCell
        
        cell.diaLabel.text = self.listEvent[indexPath.row].dia
        cell.horarioLabel.text = self.listEvent[indexPath.row].dia
        
    
        return cell
    }
    
    func getEventos(idTitulo:Int)
    {
        let idTit = String(idTitulo)
        let scriptUrl = "http://minhaopiniao.pe.hu/cine_ufes_service.php"
        let urlWithParams = scriptUrl + "?action=getEventos&idTitulo="+idTit
        let myUrl = NSURL(string: urlWithParams);
        let request = NSMutableURLRequest(URL:myUrl!);
        "http://minhaopiniao.pe.hu/cine_ufes_service.php?action=getEventos?idTitulo=1"
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
                
                
                if let convertedJsonIntoArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSArray
                {
                    
                    for json in convertedJsonIntoArray
                    {
                        var evento = Evento()
                        if let id = json ["_ID"] as? Int{  evento.id = Int(id) }
                        
                        if let data = json ["data"] as? String{ evento.data = NSDate(dateString: data) }
                        
                        if let hora = json ["hora"] as? String{ evento.hora = hora }
                        
                        if let dia = json["dia"] as? String{ evento.dia = dia }
                        
                        if let idTitulo = json ["idTitulo"] as? Int{ evento.idTitulo = Int(idTitulo) }
                        
                        self.listEvent.append(evento)
                    }
                    // Print out dictionary
                    print(convertedJsonIntoArray)
                    
                    
                
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    
}









