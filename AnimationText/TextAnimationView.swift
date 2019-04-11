//
//  TextAnimationView.swift
//  AnimationText
//
//  Created by yaojinhai on 2019/4/10.
//  Copyright © 2019年 yaojinhai. All rights reserved.
//

import UIKit

class TextAnimationView: UIView , NSLayoutManagerDelegate,CAAnimationDelegate{

    private let textStorage = NSTextStorage(string: "");
    private let textLayout = NSLayoutManager();
    private let textContainer = NSTextContainer();
    
    private var textLayers = [CALayer]();
    private var textLayerPostions = [CGPoint]();
    
    var text: String!{
        didSet{
            let textA = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor.red,NSAttributedString.Key.font:UIFont.fitSize(size: 20)]);
            textStorage.setAttributedString(textA);

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
       
        
        textStorage.addLayoutManager(textLayout);
        textLayout.addTextContainer(textContainer);
        textLayout.delegate = self;
        textContainer.size = bounds.size;
        textContainer.maximumNumberOfLines = 0;
        
    }

    
    
    
    func layoutManager(_ layoutManager: NSLayoutManager, didCompleteLayoutFor textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool) {
        
        
        if layoutFinishedFlag {
            calculateLayer();
        }
        
    }
    
    func calculateLayer() -> Void {
        textLayers.removeAll();
        textLayerPostions.removeAll();
        if text == nil {
            return;
        }
        
        var index = 0;
        
        while index < text.count {
            
            let glyRang = NSRange(location: index, length: 1);
            
            let count = textStorage.attributedSubstring(from: glyRang);
            

            let charRange = textLayout.characterRange(forGlyphRange: glyRang, actualGlyphRange: nil);
            let glyRect = textLayout.boundingRect(forGlyphRange: glyRang, in: textContainer);
            
            let textLayer = CATextLayer();
            textLayer.string = count;
            textLayer.frame = glyRect;
            textLayer.backgroundColor = UIColor.clear.cgColor;
            textLayer.contentsScale = iOSIPhoneInfoData.scale;
            layer.addSublayer(textLayer);
            textLayers.append(textLayer);
            textLayerPostions.append(textLayer.position);

            index += charRange.length;

        }
    }
    
    func runTextAnimationPostion() -> Void {
        
        for (idx,item) in textLayers.enumerated() {
            item.position = textLayerPostions[idx];
            item.removeAllAnimations();
        }
        
        for (index,item) in textLayers.enumerated() {
            let position = textLayerPostions[index];
            
            let point = CGPoint(x: item.position.x, y: -100);
            item.position = point;
            let animation = CABasicAnimation(keyPath: "position");
            animation.fromValue = point
            animation.toValue = position;
            let duration = Double(10.1 / Double(textLayers.count));
            animation.duration = duration;
            animation.repeatCount = 1;
            animation.beginTime = CACurrentMediaTime() + Double(index) * duration;
            animation.fillMode = .forwards;
            animation.isRemovedOnCompletion = false;
            item.add(animation, forKey: "\(index)");
            
            
        }
        
    }

    
    func runTextAnimation() -> Void {
        runTextAnimationPostion();
        return;
        for item in textLayers {
            var transform = CATransform3DRotate(item.transform, .pi/4, 0, 0, 1);
            transform.m34 = 0.1/400.0;
            
            let animation = CABasicAnimation(keyPath: "transform");
            animation.fromValue = transform//CGPoint(x: CGFloat(arc4random_uniform(UInt32(width))), y: CGFloat(arc4random_uniform(UInt32(height))));
            animation.toValue = item.transform;
            animation.duration = 4;
            animation.repeatCount = 1;
            animation.fillMode = .forwards;
            animation.isRemovedOnCompletion = false;
            item.add(animation, forKey: "123");
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
