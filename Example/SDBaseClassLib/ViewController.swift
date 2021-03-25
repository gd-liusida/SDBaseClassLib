//
//  ViewController.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 03/21/2021.
//  Copyright (c) 2021 Liu Sida. All rights reserved.
//

import UIKit
import SDBaseClassLib

class ViewController: UIViewController {

    let activeLabel = SDActiveLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customType = SDActiveType.custom(pattern: "\\ssupports\\b")
        let customType2 = SDActiveType.custom(pattern: "\\ssupported\\b") //Looks for "it"
        let customType3 = SDActiveType.custom(pattern: "supports") //Looks for "supports"

        activeLabel.enabledTypes.append(customType)
        activeLabel.enabledTypes.append(customType2)
        activeLabel.enabledTypes.append(customType3)
        
        activeLabel.customize { label in
            label.text = "This is a post with #multiple #hashtags and a @userhandle. Links are also supported > like" +
            " this one: http://optonaut.co. Now it also supports custom patterns -> are\n\n" +
                "Let's trim a long link: \nhttps://twitter.com/twicket_app/status/649678392372121601"
            label.numberOfLines = 0
            label.lineSpacing = 4
            
            label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
            label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
            label.URLSelectedColor = UIColor(red: 82.0/255, green: 190.0/255, blue: 41.0/255, alpha: 1)

            label.handleMentionTap { self.alert("Mention", message: $0) }
            label.handleHashtagTap { self.alert("Hashtag", message: $0) }
            label.handleURLTap { self.alert("URL", message: $0.absoluteString) }

            //Custom types

            label.customColor[customType] = UIColor.purple
            label.customSelectedColor[customType] = UIColor.green
            label.customColor[customType2] = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
            label.customSelectedColor[customType2] = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
            
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                switch type {
                case customType3:
                    atts[NSAttributedString.Key.font] = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.boldSystemFont(ofSize: 14)
                case customType2:
                    atts[.underlineStyle] = NSUnderlineStyle.styleSingle.rawValue
                default: ()
                }
                
                return atts
            }

            label.handleCustomTap(for: customType) { self.alert("Custom type", message: $0) }
            label.handleCustomTap(for: customType2) { self.alert("Custom type", message: $0) }
            label.handleCustomTap(for: customType3) { self.alert("Custom type", message: $0) }
        }

        activeLabel.frame = CGRect(x: 20, y: 40, width: view.frame.width - 40, height: 300)
        view.addSubview(activeLabel)
        
        let label = UILabel.init()
        label.setText("字体大小")
            .setFont(UIFont.systemFont(ofSize: 15))
            .setFontSizeToFitWidth(0.6)
            .setTextColor(UIColor.black)
        view.addSubview(label)
        
        label.frame = CGRect.init(x: 20, y: activeLabel.sd_bottom + 50, width: view.sd_width, height: 50)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }

}

