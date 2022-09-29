//
//  AVAudioPlayerManager.swift
//  FreightDriver
//
//  Created by lax on 2019/12/26.
//  Copyright © 2020 众至. All rights reserved.
//

import Foundation
import AVFoundation

open class AVAudioPlayerManager: NSObject {
    
    public static let shared = AVAudioPlayerManager()
    
    /// 震动
    public static func shock() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    private var audioPlayer: AVAudioPlayer?
    
    /// 播放本地音频文件
    /// - Parameters:
    ///   - name: 文件名称
    ///   - type: 文件类型
    open func playLocalFile(_ name: String, type: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else { return }
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            AVAudioPlayerManager.shock()
        } catch {
            print(error.localizedDescription)
        }   
    }
    
}

extension AVAudioPlayerManager: AVAudioPlayerDelegate {
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
