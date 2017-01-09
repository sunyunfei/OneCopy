//
//  MusicManager.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/9.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
class MusicManager: NSObject {

    var audioPlayer: AVAudioPlayer?//定义一个播放器
    
    override init() {
       
        //添加播放器
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        let pathURL=NSURL(fileURLWithPath: path!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pathURL as URL)
        } catch {
            audioPlayer = nil
        }
        audioPlayer?.prepareToPlay()//音乐缓冲
    }
    
    //播放音乐
    func playMusic(){
    
        audioPlayer?.play()
    }
    
    func stopMusic(){
    
        audioPlayer?.pause()//停止音乐
    }
}
