//
//  ViewController.swift
//  FaceIt
//
//  Created by 박혜원 on 2020/12/11.
//

import UIKit

class FaceViewController: UIViewController {

    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smirk) {
        didSet{
            updateUI() // 모델 값이 바뀐다면 View도 바뀌어야 한다
            // 처음 초기화중에는 호출되지 않는다.
        }
    }

    /* 처음 초기화시 호출되지 않는 문제를 해결하기 위해서 didSet으로 updateUI를 호출한다. 이는 뷰와 연결 될 때 호출되는 함수이다 */
    @IBOutlet weak var faceView: FaceView!{
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            // 위로 swipe하는 경우 웃는 얼굴로
            let happierSwipeGestireRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGestireRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestireRecognizer)
            
            // 아래로 swipe하는 경우 시무룩한 얼굴로
            let sadderSwipeGestireRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness))
            sadderSwipeGestireRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestireRecognizer)
            updateUI()
        }
    }
    @objc func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    @objc func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended{
            switch expression.eyes { // 현재 눈의 상태에 따라
            case .Open : expression.eyes = .Closed // 눈을 뜬 경우 감게 함
            case .Closed : expression.eyes = .Open // 눈을 감은 경우 뜨게 함
            case .Squinting : break
            }
        }
    }
    private var mouthCurvatures = [FacialExpression.Mouth.Frown : -1.0, .Grin: 0.5, .Smile : 1.0 ,.Smirk : -0.5, .Neutral: 0.0] // model과 view 사이의 mapping, 두번째 인자부터는 타입추론이 가능하므로 FacialExpression. 을 반복하여 쓸 필요가 없다
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]
    
    private func updateUI() {
        switch expression.eyes { // 눈을 뜨고 있는 상황이라면
        case .Open : faceView.eyesOpen = true
        case .Closed : faceView.eyesOpen = false
        case .Squinting : faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        //dictionaly lookup 과정에서 반환값은 optional 값이다. nil을 반환하는 경우 default value 로 0.0으로 설정한다.
        faceView.eyeBrowtilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
}

