//
//  YXMainViewController.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import UIKit

@objcMembers public class YXMainViewController: YXBaseViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CategaryList.execute()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
