import UIKit

class ViewController: UIViewController {

    private let rectWidth: CGFloat = 200
    private let rectHeight: CGFloat = 200
    private let ptOffset: CGFloat
    
    
    init() {
        self.ptOffset = (self.rectHeight / 2) + 20
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addRect_CornerRadius()
        self.addRect_UIBezierPath()
    }
    
    
    private func addRect_CornerRadius() {
        let rect = ViewController.self.createRectView(width: self.rectWidth,
                                                      height: self.rectHeight,
                                                      centerPt: super.view.center,
                                                      posOffset: -self.ptOffset,
                                                      bg: .systemRed)
        
        rect.layer.cornerRadius = 80
        super.view.addSubview(rect)
    }
    
    private func addRect_UIBezierPath() {
        let rect = ViewController.createRectView(width: self.rectWidth,
                                                 height: self.rectHeight,
                                                 centerPt: super.view.center,
                                                 posOffset: self.ptOffset,
                                                 bg: .systemBlue)
        
        rect.layer.mask = ViewController.createMask(width: self.rectWidth, height: self.rectHeight, offset: 25)
        super.view.addSubview(rect)
    }
    
    // MARK:- static func
    
    private static func createRectView(width: CGFloat, height: CGFloat, centerPt: CGPoint, posOffset: CGFloat, bg: UIColor) -> UIView {
        let rectView = UIView()
        rectView.frame.size = CGSize(width: width, height: height)
        rectView.center = centerPt
        rectView.center.y += posOffset
        rectView.backgroundColor = bg
        
        return rectView
    }
    
    private static func createMask(width: CGFloat, height: CGFloat, offset: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath()
        
        let startPt = CGPoint(x: width / 2, y: 0)
        path.move(to: startPt)
        
        let right_destPt = CGPoint(x: width, y: height / 2)
        let right_control1Pt = CGPoint(x: width - offset, y: 0)
        let right_control2Pt = CGPoint(x: width, y: offset)
        path.addCurve(to: right_destPt, controlPoint1: right_control1Pt, controlPoint2: right_control2Pt)
        
        let bottom_destPt = CGPoint(x: width / 2, y: height)
        let bottom_control1Pt = CGPoint(x: width, y: height - offset)
        let bottom_control2Pt = CGPoint(x: width - offset, y: height)
        path.addCurve(to: bottom_destPt, controlPoint1: bottom_control1Pt, controlPoint2: bottom_control2Pt)
        
        let left_destPt = CGPoint(x: 0, y: height / 2)
        let left_control1Pt = CGPoint(x: offset, y: height)
        let left_control2Pt = CGPoint(x: 0, y: height - offset)
        path.addCurve(to: left_destPt, controlPoint1: left_control1Pt, controlPoint2: left_control2Pt)
        
        let top_destPt = startPt
        let top_control1Pt = CGPoint(x: 0, y: offset)
        let top_control2Pt = CGPoint(x: offset, y: 0)
        path.addCurve(to: top_destPt, controlPoint1: top_control1Pt, controlPoint2: top_control2Pt)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        return maskLayer
    }
}
