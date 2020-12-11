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
            updateUI() // // 모델 값이 바뀐다면 View도 바뀌어야 한다
            // 처음 초기화될때는 호출되지 않는다
        }
    }

    /* 처음 초기화시 호출되지 않는 문제를 해결하기 위해서 didSet으로 updateUI를 호출한다. 이는 뷰와 연결 될 때 호출되는 함수이다 */
    @IBOutlet weak var faceView: FaceView!{ didSet { updateUI() } }
    
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown : -1.0, .Grin: 0.5, .Smile : 1.0 ,.Smirk : -0.5, .Neutral: 0.0] // model과 view 사이의 mapping
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]
    
    private func updateUI() {
        switch expression.eyes {
        case .Open : faceView.eyesOpen = true
        case .Closed : faceView.eyesOpen = false
        case . Squinting : faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowtilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
}

