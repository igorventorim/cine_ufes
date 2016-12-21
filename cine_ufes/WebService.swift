//
//  WebService.swift
//  cine_ufes
//
//  Created by Student on 12/20/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import Foundation

class WebService
{
    static func getTitulos() -> [Titulo]
    {
        
        var listTitulos:[Titulo] = [Titulo]()
        
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
                        var titulo = Titulo()
                        
                        if let nome = json["nome"] as? String {titulo.nome = nome}
                        
                        if let genero = json["genero"] as? String {titulo.genero = genero}
                        
                        if let id = json["_ID"] as? String{ titulo.idTitulo = Int(id)!}
                        
                        if let img = json["imagem"] as? String{ titulo.imagem = img}
                        
                        if let nota = json["nota"] as? String{ titulo.nota = Double(nota)}
                        
                        if let tipo = json["tipo"] as? String{ titulo.tipo = Character(tipo)}
                        
                        if let sinopse = json["sinopse"] as? String{ titulo.sinopse = sinopse }
                        
                        listTitulos.append(titulo)
                    }
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        return listTitulos
    }
    
    
    
    
    static func getEventos(idTitulo:Int) -> [Evento]
    {
        var listEvento:[Evento] = [Evento]()
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
                        
                        listEvento.append(evento)
                    }
                    // Print out dictionary
                    print(convertedJsonIntoArray)
                    
                    
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        return listEvento
    }
}
