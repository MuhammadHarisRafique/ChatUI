//
//  ViewController.swift
//  ChatUI
//
//  Created by Higher Visibility on 27/12/2017.
//  Copyright © 2017 Higher Visibility. All rights reserved.
//

import UIKit
import JSQMessagesViewController

struct User{
    
    let id:String
    let name:String
}

class ViewController:JSQMessagesViewController{

    let userone = User(id: "1", name: "Haris")
    let userTwo = User(id: "2", name: "Rehan")
    
    var currentUser:User{
        
        return userone
        
    }
     var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = self.currentUser.id
        self.senderDisplayName = self.currentUser.name
        self.messages = self.getMessages()
    }

    func getMessages()->[JSQMessage]{
        
        
        var messagesArray = [JSQMessage]()
        
        let messageOne = JSQMessage(senderId: "1", displayName: "Haris", text: "hi rehan how are U?")
        let messageTwo = JSQMessage(senderId: "2", displayName: "Rehan", text: "I am Fine And U?")
        
        messagesArray.append(messageOne!)
        messagesArray.append(messageTwo!)
        
        return messagesArray
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return self.messages[indexPath.row]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        let message = self.messages[indexPath.row]
        
        if self.senderId == message.senderId{
            
             return bubbleFactory?.outgoingMessagesBubbleImage(with: .black)
        
        }else{
            
             return bubbleFactory?.incomingMessagesBubbleImage(with: .red)
            
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        
        let message = self.messages[indexPath.row]
        let user = message.senderDisplayName
        return NSAttributedString(string: user!)
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15.0
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        self.messages.append(message!)
        finishSendingMessage()
        self.receivedMessage()
 
    }
    
    
    private func receivedMessage(){
        let message = JSQMessage(senderId: "2", displayName: "Rehan", text: "Great work")
        self.messages.append(message!)
        finishReceivingMessage()
        
        
    }

}

