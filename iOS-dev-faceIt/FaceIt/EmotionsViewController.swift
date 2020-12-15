//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by 박혜원 on 2020/12/14.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    /*
     swift case 문으로 할 수도 있지만, if else 가 반복적으로 필요하므로 Dictionary를 이용한다.
     */
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]
    
    /*
     인스턴스를 가져오고 값을 설정하는 과정
     @parameter
     for segue : segue 객체를 통해 생성된 View Controller 인스턴스 참조를 읽어와야 한다.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination // 목적지가 되는 destination View Controller 인스턴스 참조를 가져온다
        /*
         segue의 초기상태가 NavigationController인 경우 NavigationContoller를 보는 것이 아닌 그 안에 있는 것을 보게 된다.
         안에 있는 것을 segue 로 연결한다.
        */
        if let navcon = destinationVC as? UINavigationController {
            /*
             인스턴스의 타입을 UIViewController에서 UINavigationContoller 타입으로 캐스팅한다.
             visibleViewController는 Optional Type이므로 visibleViewController가 존재하지 않는다면 그대로 둔다.
             */
            destinationVC = navcon.visibleViewController ?? destinationVC
        }
        
        if let faceVC = destinationVC as? FaceViewController { // FaceViewcontroller타입으로 캐스팅
            if let identifier = segue.identifier { // identifier가 nil인지 체크한다.
                if let expression = emotionalFaces[identifier] {
                    faceVC.expression = expression
                    if let sendingButton = sender as? UIButton {
                        faceVC.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
    }

}
