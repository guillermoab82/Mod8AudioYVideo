//
//  FirstViewController.swift
//  AudioyVideo
//
//  Created by Guillermo Alonso on 22/10/16.
//  Copyright © 2016 Guillermo ALonso. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController, AVAudioPlayerDelegate{
    
    var audioPlayer:AVAudioPlayer?
    var timer:NSTimer?
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderPos: UISlider!
    
    @IBAction func btnTouchPlay(sender: AnyObject) {
        self.audioPlayer!.play()
        self.btnStop.enabled = true
        self.btnPlay.enabled = false
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,selector: #selector(FirstViewController.actualizaSlider),userInfo: nil, repeats: true)
    }

    @IBAction func btnTouchStop(sender: AnyObject) {
        self.audioPlayer!.stop()
        self.btnStop.enabled = false
        self.btnPlay.enabled = true
    }
    
    @IBAction func touchSlider(sender: AnyObject) {
        self.audioPlayer!.volume = self.slider.value
    }
    
    @IBAction func sliderPosChanged(sender: AnyObject) {
        self.audioPlayer!.currentTime = Double(self.sliderPos.value)
    }
    
    func actualizaSlider() {
        let pos:Double = self.audioPlayer!.currentTime
        self.sliderPos.value=Float(pos)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //obtener url
        let strPath = NSBundle.mainBundle().pathForResource("Pantera - Cowboys From Hell", ofType: "mp3")
        let urlAlAudio = NSURL.fileURLWithPath(strPath!)
        self.cargaAudio(urlAlAudio)
        
    }
        func cargaAudio (url:NSURL)
        {
            do {
                try self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
                self.audioPlayer!.delegate = self
                
            }
            catch {
                
                let ac = UIAlertController(title: "error", message: "archivo de audio invalido o inexistente", preferredStyle: .Alert)
                let ab = UIAlertAction(title: "ya que", style: .Default, handler: nil)
                ac.addAction(ab)
                self.presentViewController(ac, animated: true, completion: nil)
            }
    
        /*if urlAlAudio == nil {
         let ac = UIAlertController(title: "error", message: "archivo de audio invalido o inexistente", preferredStyle: .Alert)
         let ab = UIAlertAction(title: "ya que", style: .Default, handler: nil)
         ac.addAction(ab)
         self.presentViewController(ac, animated: true, completion: nil) */
        // Do any additional setup after loading the view, typically from a nib.
            
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.btnTouchStop(self.btnStop)
        self.inicializaUX()
    }
    
    func inicializaUX() {
        self.btnStop.enabled = false
        self.slider.minimumValue = 0.0
        self.slider.maximumValue = 10.0
        self.slider.value = 5.0
        self.audioPlayer!.volume = self.slider.value
        self.sliderPos.minimumValue = 0.0
        let duracion:Double = self.audioPlayer!.duration
        self.sliderPos.maximumValue = Float(duracion)
        self.sliderPos.value = 0.0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

