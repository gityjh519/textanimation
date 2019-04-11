//
//  ViewController.swift
//  AnimationText
//
//  Created by yaojinhai on 2019/4/10.
//  Copyright © 2019年 yaojinhai. All rights reserved.
//

import UIKit

class ViewController: JHSBaseViewController {

    var textLabel: TextAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        createAnimationView();
    }
    
    func createAnimationView() -> Void {
        textLabel = TextAnimationView(frame: bounds().insetBy(dx: 20, dy: 80));
        addSubview(subView: textLabel);
        textLabel.backgroundColor = UIColor.white;
        textLabel.text = "1.要渲染展示的内容。2.将内容渲染在某个视图上。3.内容渲染在视图上的尺寸位置和形状。在TextKit框架中，提供了几个类分别对应处理上述的必要条件：1.NSTextStorage对应要渲染展示的内容。2.UITextView对应要渲染的视图。";
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textLabel.runTextAnimation();
    }


}

