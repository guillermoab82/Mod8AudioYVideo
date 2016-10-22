//
//  SecondViewController.swift
//  AudioyVideo
//
//  Created by Guillermo Alonso on 22/10/16.
//  Copyright © 2016 Guillermo ALonso. All rights reserved.
//

import UIKit
import AVFoundation //Para audio y video
import AVKit //Para usar AVPlayerViewController

class SecondViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var visto:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Vamos a buscar la URl del recurso
        let urlDelVideo = NSBundle.mainBundle().URLForResource("Megadeth", withExtension: "mp4")
        self.videoPlayer = AVPlayer(URL: urlDelVideo!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !visto {
            self.muestraVideo()
        }
    }

    func muestraVideo() {
        let videoPlayerController = AVPlayerViewController()
        videoPlayerController.player = self.videoPlayer!
        //Que divice es?
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            self.presentViewController(videoPlayerController, animated:true,completion:{
                self.videoPlayer!.play()
                self.visto = true
            })
        }else{
            let framePantalla = UIScreen.mainScreen().bounds
            let anchoPantalla = CGRectGetWidth(framePantalla)
            let altoPantalla = CGRectGetHeight(framePantalla)
            videoPlayerController.view.frame = CGRectMake(anchoPantalla/3, altoPantalla/3, anchoPantalla/3, altoPantalla/3)
            self.view.addSubview(videoPlayerController.view)
            self.addChildViewController(videoPlayerController)
            self.videoPlayer!.play()
            self.visto = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoPlayer!.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

