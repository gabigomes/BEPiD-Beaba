import SpriteKit

class GameViewController: UIViewController {
    
    var scene: Menu!
    var skView = SKView()
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 1. Configure the main view
        self.skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.showsPhysics = false
        
        // 2. Create and configure our game scene
        scene = Menu(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // 3. Show the scene.
        skView.presentScene(scene)
        
    }
    
}