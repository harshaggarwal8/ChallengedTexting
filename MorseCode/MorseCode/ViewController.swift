//
//  ViewController.swift
//  MorseCode
//
//  Created by Rohan Chopra on 28/09/19.
//  Copyright © 2019 Rohan Chopra. All rights reserved.
//

import UIKit
import CoreHaptics
import MessengerKit
import FirebaseDatabase

    var engine: CHHapticEngine?
class ViewController: UIViewController  {
    var visual : VisualVC?
    @IBOutlet weak var morseView: UIView!
    @IBOutlet weak var text: UILabel!


    var textval = ""
    var longPressRecognizer = UILongPressGestureRecognizer()


    var timer = Timer()


    
}

extension ViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = ""
        
  
        // Do any additional setup after loading the view.
        startHaptics()
        
     
        let tap = UITapGestureRecognizer(target: self, action: #selector(SingleTap))
        
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        
        longPressRecognizer.minimumPressDuration = 1.5
        morseView.isUserInteractionEnabled = true
        morseView.addGestureRecognizer(tap)
        morseView.addGestureRecognizer(longPressRecognizer)
        
       
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeDown)
        morseView.addGestureRecognizer(swipeDown)
       
      
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()

        
        if text.text != ""{
            print(text.text!)
                   id += 1
            let body: MSGMessageBody =  .text(text.text!)
                                  
            messagesingle = MSGMessage(id: id, body: body, user: steve, sentAt: Date())
            
            addToFirebase()
            
        }
     
        textval = ""
        text.text = ""
        FinalString = ""
    }

    
    func addToFirebase(){
      
        let ref = Database.database().reference().child("Messages")
             let number = Int.random(in: 0 ..< 11000)
        ref.child("\(number)").setValue(["Body" : text.text! , "id": 1 , "sender":1])
    }
    func playHaptics(){
    
    }
 
    @objc func SingleTap()  {
  makeHaptic()
        countervar = 0
        timer.invalidate() // Stop The word timer
        let val = "."
        
        textval = textval + val
        
        print(textval)

        text.text! += val
        startTimer()// start Start the counter for next word
    }
    
    
    
    @objc func longPress()
    {
        countervar = 0
        timer.invalidate() //Stop The word timer
        
        
            let val = "-"
        
            if longPressRecognizer.state == .ended
            {
                
                 textval = textval + val
                 text.text! += val
                  print(textval)
            }
            else
            {
makeHaptic()
            }
        

        startTimer()// For Next Word Start the counter

        
       }
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(FireTimer), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func FireTimer(){
        
        countervar += 1
        if countervar == 3 {
           
            playSoundForTap()
            makeletter()
            
        }else if countervar == 7{
            
            playSoundForTap()
            FinalString += " "
            
            text.text = FinalString
            print(FinalString)
            
    
        } else if countervar == 13{
            timer.invalidate()
            countervar = 0
            message()
            self.dismiss(animated: true, completion: nil)
         
            
        }
       
    }
    

    func makeletter()  {
        FinalString += CheckInputFor(Value: textval)
        textval = ""
            print(FinalString)
        text.text = FinalString + " "
    }
    
    
    func startHaptics(){
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
        // The engine stopped; print out why
        engine?.stoppedHandler = { reason in
            print("The engine stopped: \(reason)")
        }

        // If something goes wrong, attempt to restart the engine immediately
        engine?.resetHandler = { [weak self] in
            print("The engine reset")

            do {
                try engine?.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }

    }

    
    func message(){
        
        if let textval = text.text{
        id += 1
                       
        let body: MSGMessageBody =  .text(textval)
                       
         messagesingle = MSGMessage(id: id, body: body, user: steve, sentAt: Date())
         updation = 1
            

        }
    }
    
}
