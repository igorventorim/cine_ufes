//
//  Evento.swift
//  cine_ufes
//
//  Created by Student on 12/19/16.
//  Copyright © 2016 ufes.br. All rights reserved.
//

import Foundation

class Evento {
    
    var id:Int?
    var idTitulo:Int?
    var dia:String?
    var hora:String?
    var data:NSDate?
    
    //    init (dia:String, hora:String, data:String){
    //
    //        self.dia = dia
    //        self.hora = hora
    //        self.data = NSDate(dateString:data)
    //    }
}
extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "dd-MM-yyyy"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
}