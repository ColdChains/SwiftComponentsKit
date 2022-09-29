//
//  UIImpactFeedbackGenerator.swift
//  FreightDriver
//
//  Created by lax on 2019/12/31.
//  Copyright © 2020 众至. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

open class FeedbackGeneratorManager {
    
    public static func shock() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    public static func occurred() {
        if #available(iOS 10.0, *) {
            let feedBackGenertor = UIImpactFeedbackGenerator(style: .light)
            feedBackGenertor.impactOccurred()
        } else {
            // Fallback on earlier versions
        }
    }
    
    public static func occurredMedium() {
        if #available(iOS 10.0, *) {
            let feedBackGenertor = UIImpactFeedbackGenerator(style: .medium)
            feedBackGenertor.impactOccurred()
        } else {
            // Fallback on earlier versions
        }
    }
    
    public static func occurredHeavy() {
        if #available(iOS 10.0, *) {
            let feedBackGenertor = UIImpactFeedbackGenerator(style: .heavy)
            feedBackGenertor.impactOccurred()
        } else {
            // Fallback on earlier versions
        }
    }
    
    public static func occurredSoft() {
        if #available(iOS 13.0, *) {
            let feedBackGenertor = UIImpactFeedbackGenerator(style: .soft)
            feedBackGenertor.impactOccurred()
        } else {
            // Fallback on earlier versions
        }
    }
    
}
