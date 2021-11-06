//
//  Birthday.swift
//  BirthdayTracker
//
//  Created by Matthew on 06.11.2021.
//

import Foundation

class Birthday {
    
    let firstName: String
    let lastName: String
    let birthDate: Date
    
    init(firstName:String,lastName:String,birthDate:Date){
        
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}
