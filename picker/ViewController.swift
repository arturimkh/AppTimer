
import UIKit

class ViewController: UIViewController {
    let lessonLabel: UILabel = {
        let label = UILabel()
        label.text = "timer by artur imanbaev"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }() //Создаем лейбл сверху экрана
    let customButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.setTitle("Enter seconds", for: .normal)
        button.backgroundColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()// Создаем кнопку снизу экрана
    let shapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "318506-200")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "timer"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 40
        button.setTitle("Start", for: .normal)
        button.backgroundColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()// Создаем кнопку снизу экрана
    
    
    
    var timer = Timer()
    
    let shapeLayer = CAShapeLayer()
    
    var durationTimer : Int = 0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "\(durationTimer)"
        view.backgroundColor = .white
        setConstrains()// добавляем всю верстку и ставим констрэинсы
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func customButtonTapped(){
        self.alert(title: "Hello", message: "Enter seconds", style: .alert)
        
    }
    func alert(title: String,message: String, style: UIAlertController.Style){
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default){(action) in
            let textTimer = alertController.textFields?.first
            self.durationTimer = (Int(textTimer!.text!))!
            self.timerLabel.text = "\(self.durationTimer)"
        }
        
        alertController.addTextField()
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        }
    @objc func startButtonTapped(){
        basicAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction(){
        durationTimer -= 1
        if(durationTimer == 0){
            timerLabel.text = "finish"
            timer.invalidate()
        }
        else{
            timerLabel.text = "\(durationTimer)"
        }
        print(durationTimer)
    }
    //MARK: Animation
    func animationCircular(){
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 1.5 * CGFloat.pi
        
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 105, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 28
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeView.layer.addSublayer(shapeLayer)
        
        
    }
    func basicAnimation(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    
}
extension ViewController{
    func setConstrains(){
        view.addSubview(lessonLabel)
        NSLayoutConstraint.activate([
            lessonLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 150),
            lessonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lessonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        view.addSubview(shapeView)
        NSLayoutConstraint.activate([
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 300),
            shapeView.widthAnchor.constraint(equalToConstant: 300)

        ])
        view.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor)
        ])
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        view.addSubview(customButton)
            NSLayoutConstraint.activate([
                customButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
                customButton.centerXAnchor.constraint(equalTo: lessonLabel.centerXAnchor),
                customButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}




