//
//  MessageBoxVC.swift
//  MorseCode
//
//  Created by Rohan Chopra on 28/09/19.
//  Copyright © 2019 Rohan Chopra. All rights reserved.
//

import UIKit
import MessengerKit
import MessageUI
import Pastel
import FirebaseDatabase


class MessageBoxVC: MSGMessengerViewController, UITextViewDelegate {

    // Users in the cha
        // Messages
        
        // Lifecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        messagesvar.removeAll()
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            dataSource = self
            
            print(view.frame.height)
            
            let Button = UIButton(frame: CGRect(x: 10, y: 702, width: 360, height: 70))

            Button.setTitle("TAP ME", for: .normal)
            

            Button.backgroundColor = UIColor.black

           // self.view.addSubview(Button)
            
            objfire()
            
    }
    
    
      func objfire(){
          let ref = Database.database().reference()
          
          ref.child("Messages").observe(.childAdded, with: {(snapshot) in
              
              if let snap = snapshot.value as? [String:Any]{
                print(snap)
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
    

    }

    // MARK: - MSGDataSource

    extension MessageBoxVC: MSGDataSource {
        
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
                
                let ref = Database.database().reference().child("Messages")
                           let number = Int.random(in: 0 ..< 11000)
                      ref.child("\(number)").setValue(["Body" : inputView.message , "id": 1 , "sender":1])
                
             
            }
            
            override func insert(_ message: MSGMessage) {
                
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


        
}
