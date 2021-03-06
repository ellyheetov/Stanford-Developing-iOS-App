//
//  FaceView.swift
//  FaceIt
//
//  Created by 박혜원 on 2020/12/11.
//

import UIKit

@IBDesignable // 인터페이스 빌더가 story보드에 그림을 그려준다
class FaceView: UIView {
    
    // IBInspectable을 사용하기 위해서는 변수의 타입을 명시적으로 적어야한다
    @IBInspectable // 인스펙터 설정창에서 확인할 수 있다
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay()}} // setNeedsDisplay는 다시 그려져야 함을 의미한다
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay()}} // 1 full smile, -1 full full frown
    @IBInspectable
    var eyesOpen: Bool = true { didSet { setNeedsDisplay()}}
    @IBInspectable
    var eyeBrowtilt: Double = 0.0 { didSet { setNeedsDisplay()}} // 1 fully  relaxed, -1 full furrow
    @IBInspectable
    var color: UIColor = UIColor.blue { didSet { setNeedsDisplay()}}
    @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay()}} // 선 굵기
    
    @objc func changeScale(recognizer: UIPinchGestureRecognizer){ // recognizer scale 재설정
        switch recognizer.state {
        case .changed, .ended : // scale이 움직이면 스케일 확장이나 축소를 점점 증가 시킴
            scale *= recognizer.scale
            recognizer.scale = 1.0 // scale이 계속 누적되는것을 방지하기 위해 1.0 으로 매번 초기화 한다.
        default: break // 나머지는 아무것도 하지 않음
        }
    }
    
    /* 두개골의 사이즈에따라 눈과 입의 사이즈도 변경된다.*/
    private var skullRadius: CGFloat{
        /* 값을 가져오기만 하는 property의 경우 get이라고 따로 명명할 필요 없다*/
        return min(bounds.size.width, bounds.size.height)/2 // 뷰의 너비와 높이의 최솟값
    }
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY) // 나의 좌표계로 변환
    }
    
    // 두개골 반경과 눈의 사이즈 등등
    // swfit에서 상수를 만드는 방법 : 구조체를 선언해서 사용한다
    // static은 구조체에서 상수를 나타낸다
    private struct Ratios { // 상대적인 위치
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 5
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, widthRadius radius: CGFloat) -> UIBezierPath {
        let path =  UIBezierPath(
            arcCenter: midPoint, // 호의 중심
            radius: radius, // 두개골의 반지름
            startAngle: 0.0, // literal이므로 다른 타입의 숫자로 변환할 수있다. 따라서 Double이아닌 CGFloat 값을 취하게 된다.
            endAngle: CGFloat(2 * Double.pi), // Radian 법으로 0에서 360까지 그림, Double 타입을 CGFloat로 변환
            clockwise: false // 반시계방향으로 그림
        )
        path.lineWidth = lineWidth // 선굵기
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset // - is up, + is down
        
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset // - is left
        case .Right : eyeCenter.x += eyeOffset // + is right
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius // 눈의 반경
        let eyeCenter = getEyeCenter(eye: eye)
        
        if eyesOpen {
            return pathForCircleCenteredAtPoint(midPoint: eyeCenter, widthRadius: eyeRadius)
        } else {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
    }
    
    private func pathForBrow(eye: Eye) -> UIBezierPath {
        var tilt = eyeBrowtilt
        switch eye {
        case .Left : tilt *= -1.0
        case .Right: break
        }
        var browCenter = getEyeCenter(eye: eye)
        
        browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max( -1, min(tilt, 1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        
        let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
    
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth/2,
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight
        )
    
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.minX,y: mouthRect.minY)
        
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
        
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForCircleCenteredAtPoint(midPoint: skullCenter, widthRadius: skullRadius).stroke()
        pathForEye(eye: .Left).stroke() // type추론에 의하여 Eye가 올 것을 알기 때문에 Eye.Left라고 하지 않아도 괜찮다
        pathForEye(eye: .Right).stroke()
        pathForMouth().stroke()
        pathForBrow(eye: .Left).stroke()
        pathForBrow(eye: .Right).stroke()
    }
}
