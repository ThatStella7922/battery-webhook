//
//  SessionDelegate.swift
//  dcbattwebhook-swift
//
//  Created by Dhinak G on 8/1/23.
//

import Foundation
#if os(iOS) || os(watchOS)
import WatchConnectivity
#endif


// Custom notifications happen when Watch Connectivity activation or reachability status changes,
// or when receiving or sending data. Clients observe these notifications to update the UI.
//
extension Notification.Name {
    static let dataDidFlow = Notification.Name("DataDidFlow")
    static let activationDidComplete = Notification.Name("ActivationDidComplete")
    static let reachabilityDidChange = Notification.Name("ReachabilityDidChange")
}

private let defaults = UserDefaults.standard

// Implement WCSessionDelegate methods to receive Watch Connectivity data and notify clients.
// Handle WCSession status changes.
//
class SessionDelegator: NSObject, WCSessionDelegate {
    
    // Monitor WCSession activation state changes.
    //
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }
    
    // Monitor WCSession reachability state changes.
    //
    func sessionReachabilityDidChange(_ session: WCSession) {

    }
    
    // Did receive an app context.
    //
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        for (key, value) in applicationContext {
            defaults.set(value, forKey: key)
        }
    }
    
    // Did receive a message, and the peer doesn't need a response.
    //
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {

    }
    
    // Did receive a message, and the peer needs a response.
    //
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        self.session(session, didReceiveMessage: message)
        replyHandler(message) // Echo back the time stamp.
    }
    
    // Did receive a piece of message data, and the peer doesn't need a response.
    //
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {

    }
    
    // Did receive a piece of message data, and the peer needs a response.
    //
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        self.session(session, didReceiveMessageData: messageData)
        replyHandler(messageData) // Echo back the time stamp.
    }
    
    // Did receive a piece of userInfo.
    //
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {

    }
    
    // Did finish sending a piece of userInfo.
    //
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {

    }
    
    // Did receive a file.
    //
    func session(_ session: WCSession, didReceive file: WCSessionFile) {

    }
    
    // Did finish a file transfer.
    //
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {

    }
    
    // WCSessionDelegate methods for iOS only.
    //
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif
}
