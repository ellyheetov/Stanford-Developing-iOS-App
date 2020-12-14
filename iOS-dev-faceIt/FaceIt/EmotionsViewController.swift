//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by 박혜원 on 2020/12/14.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination // 목적지가 되는 destination View Controller를 연결지어준다.
        
        if let faceVC = destinationVC as? FaceViewController { // FaceViewcontroller로 클래스를 다운캐스팅
            if let identifier = segue.identifier { // identifier가 nil인지 체크한다.
                /*
                 swift case 문으로 할 수도 있지만, if else 가 반복적으로 필요하므로 Dictionary를 이용한다.
                 */
                if let expression = emotionalFaces[identifier] {
                    faceVC.expression = expression
                }
            }
        }
    }

}
