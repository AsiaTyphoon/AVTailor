//
//  ViewController.swift
//  AVTailor
//
//  Created by dfsx6 on 2020/8/28.
//  Copyright © 2020 tg.ltd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let currentBundle = Bundle.init(for: self.classForCoder)
        let composition = AVMutableComposition.init()

        for i in 1...10 {
            guard let url = currentBundle.url(forResource: "video_call_begin\(i)", withExtension: "mp3") else {
                continue
            }
            let urlasset = AVURLAsset.init(url: url)
            // 音频轨道
            let compositionTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: CMPersistentTrackID(i))
            // 音频素材轨道
            guard let track = urlasset.tracks(withMediaType: .audio).first else {
                return
            }

            // 音频合并 - 插入音轨文件
            do {
                try compositionTrack?.insertTimeRange(CMTimeRange.init(start: .zero, duration: urlasset.duration), of: track, at: .zero)

            } catch {
                print("插入音轨文件错误: \(error.localizedDescription)")
            }
        }
        
//        guard let beginUrl = currentBundle.url(forResource: "video_call_begin1", withExtension: "mp3") else {
//            return
//        }
//        let assetBegin = AVURLAsset.init(url: beginUrl)
//
//
//        guard let endUrl = currentBundle.url(forResource: "video_call_begin1111", withExtension: "mp3") else {
//            return
//        }
//        let assetEnd = AVURLAsset.init(url: endUrl)
//
//
//        // 音频轨道
//        let compositionTrackBegin = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: .zero)
//        let compositionTrackEnd = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: .zero)
//
//        // 音频素材轨道
//        guard let trackBegin = assetBegin.tracks(withMediaType: .audio).first else {
//            return
//        }
//        guard let trackEnd = assetEnd.tracks(withMediaType: .audio).first else {
//            return
//        }
//
//        // 音频合并 - 插入音轨文件
//        do {
//            try compositionTrackBegin?.insertTimeRange(CMTimeRange.init(start: .zero, duration: assetBegin.duration), of: trackBegin, at: .zero)
//            try compositionTrackEnd?.insertTimeRange(CMTimeRange.init(start: .zero, duration: assetEnd.duration), of: trackEnd, at: .zero)
//
//        } catch {
//            print("插入音轨文件错误: \(error.localizedDescription)")
//        }

        // 合并后的文件导出
        let session = AVAssetExportSession.init(asset: composition, presetName: AVAssetExportPresetAppleM4A)
        session?.outputFileType = .m4a
        let outPutFilePath = "/Users/dfsx6/Documents/github/AVTailor/AVTailor/resources/new.m4a"
        session?.outputURL = URL.init(fileURLWithPath: outPutFilePath)
        session?.exportAsynchronously(completionHandler: {
            
        })
        
        print(#file, #function)
    }
}

