//
//  NavigationController.swift
//  TicTacToe
//
//  Created by Alberto Bernal Salgado on 3/6/24.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    func popViewController(animated: Bool, validate: Bool) -> UIViewController? {
        if validate {
            return popViewController(animated: animated)
        } else {
            return super.popViewController(animated: animated)
        }
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let controller = topViewController
        guard controller is GameViewController else { return super.popViewController(animated: animated) }
        
        let alert = UIAlertController(title: "End Game?", message: "Are you sure you want to go back? This will end the game.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "I'm sure", style: UIAlertAction.Style.default, handler: {_ in
            super.popViewController(animated: animated) //How can I return the removed controller?
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        return nil
    }
}
