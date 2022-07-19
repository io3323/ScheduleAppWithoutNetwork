//
//  ContactModel.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 09.07.2022.
//


import Foundation
import RealmSwift
class ContactModel:Object{
    @Persisted var contactsName = "Unknown"
    @Persisted var contactsPhone = "Unknown"
    @Persisted var contactsMail = "Unknown"
    @Persisted var contactsType = "Unknown"
    @Persisted var contactsImage: Data?
}
