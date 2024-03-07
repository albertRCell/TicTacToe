//
//  PlayersViewController.swift
//  TicTacToe
//
//  Created by Alberto Bernal Salgado on 3/6/24.
//

import Foundation
import UIKit

class PlayersViewController: UIViewController {
    @IBOutlet weak var playerOneName: UITextField!
    @IBOutlet weak var playerTwoName: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneName.delegate = self
        playerTwoName.delegate = self
        playerOneName.addTarget(self, action: #selector(PlayersViewController.textFieldChanged(_:)), for: .editingChanged)
        playerTwoName.addTarget(self, action: #selector(PlayersViewController.textFieldChanged(_:)), for: .editingChanged)
        updateButtonAvailability()
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        updateButtonAvailability()
    }
    
    func moveFocus() {
        if playerOneName.isFirstResponder {
            playerOneName.resignFirstResponder()
            playerTwoName.becomeFirstResponder()
        } else if playerTwoName.isFirstResponder {
            playerTwoName.resignFirstResponder()
        }
    }
    
    func updateButtonAvailability() {
        startButton.isEnabled = playerOneName.text?.isEmpty != true && playerTwoName.text?.isEmpty != true 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! GameViewController
        controller.playerOne = playerOneName.text ?? ""
        controller.playerTwo = playerTwoName.text ?? ""
    }
    
}

extension PlayersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moveFocus()
        return true
    }
}
