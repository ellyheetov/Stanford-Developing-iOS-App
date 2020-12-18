//
//  ImageViewController.swift
//  Cassini
//
//  Created by 박혜원 on 2020/12/18.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{
        return imageView
    }
    
    private func fetchImage() {
        if let url = imageURL {
            /*
             메인쓰레드에서 동작하는 것이 아니라 global Queue에서 사용자가 특정 행위를 시작할 떄 발생하도록 한다.
             클로져 내에서 self를 사용할 때, self가 해당 클로져를 향하고 있는지 확인해야한다. (메모리 사이클을 방지하기 위해)
             향하고 있지 않기 때문에 문제가 없어보이지만, 만약, 해당 ViewController를 사용자에 의해 쓸모없게 된다면(이미지를 생성하고 back 버튼을 누른 경우) 힙 속에 계속 데이터가 남아있게 된다. 이를 방지하기 위해서 weak를 사용한다.
             */
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                // UI와 관련된 것은 main 큐에서 실행되어야 한다. 따라서 다시 메인큐에서 디스패치 해주어야 한다.
                DispatchQueue.main.async {
                    /*
                     클로져는 주변에 있는 지역변수를 참조할 수 있는 특성을 가진다.
                     다른 작업을 먼저 처리하고 돌아온 DispatchQueue에 있는 url은 앞에서 설정된 url 지역변수와 다를 수 있다.
                     때문에 호출하게되는 URL이 동일한 URL인지 확인한다.
                     실시간으로 변하는 url 주소를 처리하기 위해서 확인하는 과정이다.
                    */
                    if let imageData = urlContents, url == self?.imageURL {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
}
