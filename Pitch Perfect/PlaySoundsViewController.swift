
import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var parrotButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var outerStack: UIStackView!
    @IBOutlet var innerStack: [UIStackView]!
    
    var recordedAudioUrl: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        
        print("playing sound")
        switch ButtonType(rawValue: sender.tag)! {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(playState: .Playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        
        print("playing sound stopped")
        stopAudio()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        configureUI(playState: .NotPlaying)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let orientation = UIApplication.shared.statusBarOrientation
        
        print("orientation: \(orientation.isLandscape)")
        
        if orientation.isPortrait {
            
            outerStack.axis = .vertical
            setInnerStackViewsAxis(axisOrientation: .horizontal)
        }
        else if orientation.isLandscape {
            
            outerStack.axis = .horizontal
            setInnerStackViewsAxis(axisOrientation: .vertical)
        }
    }
    
    func setInnerStackViewsAxis(axisOrientation: UILayoutConstraintAxis) {
        
        for stack in innerStack {
            
            stack.axis = axisOrientation
        }
    }
    
}
