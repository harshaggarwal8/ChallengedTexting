//
//  Data.swift
//  MorseCode
//
//  Created by Rohan Chopra on 28/09/19.
//  Copyright © 2019 Rohan Chopra. All rights reserved.
//

import Foundation
import CoreHaptics
import MessengerKit

var FinalString = ""
var countervar = 0
var countforhaptics = 0

public class datavalues {
    public var body:String?
    public var sender: String?
    public var id: Int?
}


var eventsarray = [CHHapticEvent]()

var dataSet = [ ".-" : "a" ,
            "a" :".-",
            "-...": "b"  ,
         "-.-.":   "c",
         "-..":   "d",
         ".":   "e",
         "..-.":"f" ,
         "--.":   "g",
         "....":  "h" ,
         "..":   "i",
         ".---": "j"  ,
         "-.-":   "k",
         ".-..":  "l" ,
         "--":   "m",
         "-.":   "n",
         "---":  "o" ,
         ".--.":  "p" ,
         "--.-":   "q",
         ".-.":   "r",
         "...":   "s",
         "-":   "t",
         "..-": "u"  ,
         "...-":  "v" ,
         ".--":   "w",
         "-..-":  "x" ,
         "-.--":   "y",
         "--..":   "z",
         "-----":  "0" ,
         ".----":   "1",
         "..---":   "2",
         "...--":   "3",
         "....-":   "4",
         ".....":   "5",
         "-....":   "6",
         "--...":   "7",
         "---..":   "8",
         "----.":  "9",
        ".-.-.-":    "." ,
         "--..--":    "," ,
         "..--..":   "?" ,
         "/": " "
]

var dataSetFortextToMorse :[Character: String] = [
    "a" :".-" ,
    "b" : "-...",
    "c" : "-.-.",
    "d" : "-..",
    "e" : ".",
    "f" : "..-.",
    "g" : "--.",
    "h" : "....",
    "i" : "..",
    "j" : ".---",
    "k" : "-.-",
    "l" : ".-..",
    "m" : "--",
    "n" : "-.",
    "o" : "---",
    "p" : ".--.",
    "q" : "--.-",
    "r" : ".-.",
    "s" : "...",
    "t" : "-",
    "u" : "..-",
    "v" : "...-",
    "w" : ".--",
    "x" : "-..-",
    "y" : "-.--",
    "z" : "--..",
    "0" : "-----",
    "1" : ".----",
    "2" : "..---",
    "3" : "...--",
    "4" : "....-",
    "5" : ".....",
    "6" : "-....",
    "7" : "--...",
    "8" : "---..",
    "9" : "----.",
    "." : ".-.-.-",
    "," : "--..--",
    "?" : "..--..",
    " " : "/"
]



public struct user: MSGUser {
    
    public var displayName: String = ""
    
    public var avatar: UIImage?
    
    public var isSender: Bool
    
    public var avatarUrl: URL?
}
