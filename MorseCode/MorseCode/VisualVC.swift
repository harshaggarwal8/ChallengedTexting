//
//  VisualVC.swift
//  MorseCode
//
//  Created by Rohan Chopra on 28/09/19.
//  Copyright © 2019 Rohan Chopra. All rights reserved.
//

import UIKit
import MessengerKit
import MessageUI
import Pastel
import CoreHaptics
import FirebaseDatabase

let steve = user(displayName: "Rohan", avatar: nil, isSender: true, avatarUrl: nil)
    
let tim = user(displayName: "Harsh", avatar: nil, isSender: false, avatarUrl: nil)

    var id = 100
 var messagesvar: [[MSGMessage]] = {
           return [
               
           ]
       }()
var messagesingle : MSGMessage?
var updation = 0


class VisualVC:  MSGMessengerViewController, UITextViewDelegate ,UINavigationControllerDelegate{
        
    var d = datavalues()
    
    override func viewWillDisappear(_ animated: Bool) {
        messagesvar.removeAll()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if updation == 1{
            insert(messagesingle!)
            updation = 0
        }
    }
        // Lifecycle
        
        override func viewDidLoad() {
               self.collectionView.reloadData()
            super.viewDidLoad()
            
            
            startHaptics()
           
            

            navigationController?.delegate = self
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            dataSource = self
            
            print(view.frame.height)
            
            let Button = UIButton(frame: CGRect(x: 0, y: 660, width: 380, height: 100))

            Button.setTitle("TAP ME", for: .normal)
            
            Button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            Button.backgroundColor = #colorLiteral(red: 0.6072533312, green: 0.6072533312, blue: 0.6072533312, alpha: 1)
            Button.addTarget(self, action: #selector(performsegue), for: .touchUpInside)
            self.view.addSubview(Button)
             objfire()
            
            
    }
    
    func objfire(){
        let ref = Database.database().reference()
        
        ref.child("Messages").observe(.childAdded, with: {(snapshot) in
            
            if let snap = snapshot.value as? [String:Any]{
                let body: MSGMessageBody =  .text(snap["Body"] as! String)
                let sender = snap["sender"] as! Int
                if sender == 1 {
                messagesingle = MSGMessage(id: snap["id"] as! Int, body:body , user: tim, sentAt: Date())
                            self.insert(messagesingle!)
                } else {
                    messagesingle = MSGMessage(id: snap["id"] as! Int, body:body , user: steve, sentAt: Date())
                                   self.insert(messagesingle!)
                
                }
            }
            
        })
        
    }
    
    @objc func performsegue(){
        
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "tap") as ViewController
        vc.visual = self
        self.present(vc, animated: true, completion: nil)

    }
    
    }

    // MARK: - MSGDataSource

    extension VisualVC: MSGDataSource {
        
        func numberOfSections() -> Int {
            return messagesvar.count
        }
        
        func numberOfMessages(in section: Int) -> Int {
            return messagesvar[section].count
        }
        
        func message(for indexPath: IndexPath) -> MSGMessage {
            return messagesvar[indexPath.section][indexPath.item]
        }
        
        func footerTitle(for section: Int) -> String? {
            return "Just now"
        }
        
        func headerTitle(for section: Int) -> String? {
            return messagesvar[section].first?.user.displayName
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            print("hello")
        }
        
            
            override func inputViewPrimaryActionTriggered(inputView: MSGInputView) {
                id += 1
                
                let body: MSGMessageBody =  .text(inputView.message)
                
                let message = MSGMessage(id: id, body: body, user: steve, sentAt: Date())
                insert(message)
            }
            
            override func insert(_ message: MSGMessage) {
                let A = message.body
                let s = String("\(A)")
                
                let tldEndIndex = s.index(s.endIndex , offsetBy: -2)
                let tldStartIndex =  s.index(s.startIndex , offsetBy: +6)
                let range = Range(uncheckedBounds: (lower: tldStartIndex, upper: tldEndIndex))
               print( s[range])
                let p = String(s[range])
                print(p)
                
            CheckMorseInputFoText(Value : p )
                
                collectionView.performBatchUpdates({
                    if let lastSection = messagesvar.last, let lastMessage = lastSection.last, lastMessage.user.displayName == message.user.displayName {
                        messagesvar[messagesvar.count - 1].append(message)
                        
                        let sectionIndex = messagesvar.count - 1
                        let itemIndex = messagesvar[sectionIndex].count - 1
                        self.collectionView.insertItems(at: [IndexPath(item: itemIndex, section: sectionIndex)])
                        
                    } else {
                        messagesvar.append([message])
                        let sectionIndex = messagesvar.count - 1
                        self.collectionView.insertSections([sectionIndex])
                    }
                }, completion: { (_) in
                    self.collectionView.scrollToBottom(animated: true)
                    self.collectionView.layoutTypingLabelIfNeeded()
                   playHaptic()
                })
                
            }
            
            override func insert(_ messages: [MSGMessage], callback: (() -> Void)? = nil) {
                
                collectionView.performBatchUpdates({
                    for message in messages {
                        if let lastSection = messagesvar.last, let lastMessage = lastSection.last, lastMessage.user.displayName == message.user.displayName {
                            messagesvar[messagesvar.count - 1].append(message)
                            
                            let sectionIndex = messagesvar.count - 1
                            let itemIndex = messagesvar[sectionIndex].count - 1
                            self.collectionView.insertItems(at: [IndexPath(item: itemIndex, section: sectionIndex)])
                            
                        } else {
                            messagesvar.append([message])
                            let sectionIndex = messagesvar.count - 1
                            self.collectionView.insertSections([sectionIndex])
                        }
                    }
                }, completion: { (_) in
                    self.collectionView.scrollToBottom(animated: false)
                    self.collectionView.layoutTypingLabelIfNeeded()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        callback?()
                    }
                })
                
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

        
}
