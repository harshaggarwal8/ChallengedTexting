//
//  Brain.swift
//  MorseCode
//
//  Created by Rohan Chopra on 28/09/19.
//  Copyright © 2019 Rohan Chopra. All rights reserved.
//

import Foundation
import AudioToolbox
import CoreHaptics

var relativeTime :TimeInterval = 0.0

  let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)


func CheckInputFor(Value : String) -> String{
    var string = ""
    
    if let value = dataSet[Value]{
        
        string += value
    }
    
        
    return string
}

 func playSoundForTap()
 {
 AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
     
 }
 
 
 
 func playSoundForLongPress()
    {
     DispatchQueue.main.async{
         for _ in 0..<3 {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
         }
     }
    }


func CheckMorseInputFoText(Value : String) {
  

    let valArray = Array(Value)
    print(valArray)
    for n in valArray{
    print(n)
        if let value = dataSetFortextToMorse[n]{
            let valArray2 = Array(value)
            print(valArray2)
                for i in valArray2{
                    checkTypeOfMorseCodeFor(value: i)
            }
        }
        
        relativeTime += 1
    }
    
        
}

func checkTypeOfMorseCodeFor(value: Character ){
    if value == "."{
      
        eventsarray.append(CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: relativeTime))
        relativeTime += 0.5
    }else if value == "-"{
        
       eventsarray.append(CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity,sharpness], relativeTime:relativeTime, duration: 0.6))
        relativeTime += 1
    }
    
}


func playHaptic(){
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    print(eventsarray)
    

    
    do {
           let pattern = try CHHapticPattern(events: eventsarray, parameters: [])
           let player = try engine?.makePlayer(with: pattern)
           try player?.start(atTime: 0)
        
        eventsarray.removeAll()
       } catch {
           print("Failed to play pattern: \(error.localizedDescription).")
       }
    
}



func makeHaptic(){
    
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)

    do {
        let pattern = try CHHapticPattern(events: [event], parameters: [])
        let player = try engine?.makePlayer(with: pattern)
        try player?.start(atTime: 0)
    } catch {
        print("Failed to play pattern: \(error.localizedDescription).")
    }
}
