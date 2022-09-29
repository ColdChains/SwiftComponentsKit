//
//  SpeechSynthesizerManager.swift
//  FreightDriver
//
//  Created by lax on 2019/12/26.
//  Copyright © 2020 众至. All rights reserved.
//

import Foundation
import AVFoundation
import CoreTelephony

public protocol AVSpeechSynthesizerManagerDelegate: NSObjectProtocol {
    
    /// 语音播报结束回调
    func speechSynthesizerManagerDidEndSpeak(_ manager: AVSpeechSynthesizerManager)
    
}

public extension AVSpeechSynthesizerManagerDelegate {
    
    func speechSynthesizerManagerDidEndSpeak(_ manager: AVSpeechSynthesizerManager) {}
    
}

extension AVSpeechSynthesizerManager {
    
    public enum Level: Int {
        case low
        case middle
        case high
    }
    
    public enum Speed: Float {
        case slow = 0.5
        case middle = 0.55
        case fast = 0.6
    }
    
}

open class AVSpeechSynthesizerManager: NSObject {
    
    public weak var delegate: AVSpeechSynthesizerManagerDelegate?
    
    public static let shared = AVSpeechSynthesizerManager()
    
    /// 语音播报
    private lazy var avSpeechSynthesizer: AVSpeechSynthesizer = {
        let avSpeechSynthesizer = AVSpeechSynthesizer()
        avSpeechSynthesizer.delegate = self
        return avSpeechSynthesizer
    }()
    
    /// 播报优先级
    private var level: Level = .middle
    
    /// 是否正在播报
    private var isSpeaking = false
    
    /// 是否正在打电话
    private var isCalling = false
    
    private lazy var callCenter: CTCallCenter = {
        let callCenter = CTCallCenter()
        return callCenter
    }()
    
    public override init() {
        do {
            //语音冲突处理
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// 停止语音播报
    private func stopAVSpeechSynthesizer() {
        level = .low
        isSpeaking = false
        avSpeechSynthesizer.stopSpeaking(at: .immediate)
        if !avSpeechSynthesizer.isSpeaking { return }
        avSpeechSynthesizer.delegate = nil
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
        avSpeechSynthesizer = synthesizer
    }
    
    /// 启动监听
    open func start() {
        //打电话监听
        callCenter.callEventHandler = { [weak self] (call: CTCall) -> Void in
            switch call.callState {
            case CTCallStateConnected, CTCallStateIncoming, CTCallStateDialing:
                self?.isCalling = true
                self?.avSpeechSynthesizer.pauseSpeaking(at: .word)
            default:
                self?.isCalling = false
                self?.avSpeechSynthesizer.continueSpeaking()
            }
        }
    }
    
    /// 语音播报
    /// - Parameters:
    ///   - voiceString: 播报内容
    ///   - level: 播报优先级
    ///   - speed: 播报速度
    open func speak(_ voiceString: String?, level: Level = .middle, speed: Speed = .middle) {
        guard let str = voiceString, str != "" else { return }
        if isCalling {
            return
        }
        if level.rawValue > self.level.rawValue {
            stopAVSpeechSynthesizer()
        }
        self.level = level
        isSpeaking = true
        let speechUtterance = AVSpeechUtterance(string: str)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        //设置语速，范围0-1，0最慢，1最快
        speechUtterance.rate = speed.rawValue
        avSpeechSynthesizer.speak(speechUtterance)
    }
    
    /// 停止播报
    open func stop() {
        stopAVSpeechSynthesizer()
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension AVSpeechSynthesizerManager: AVSpeechSynthesizerDelegate {
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        level = .low
        isSpeaking = false
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
        delegate?.speechSynthesizerManagerDidEndSpeak(self)
    }
    
}
