//
//  IntentHandler.swift
//  IntentsExtension
//
//  Created by Stella Luna on 2/8/24.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        guard intent is SendBatteryInfoIntent else {
            fatalError("An unknown Intents error occurred. Please try again.")
        }
        
        return BatteryWebhookIntentHandler()
    }
    
}
