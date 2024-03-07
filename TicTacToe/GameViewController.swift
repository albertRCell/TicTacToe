//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Alberto Bernal Salgado on 3/6/24.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var leftTopImage: UIImageView!
    @IBOutlet weak var centerTopImage: UIImageView!
    @IBOutlet weak var rightTopImage: UIImageView!
    @IBOutlet weak var leftCenterImage: UIImageView!
    @IBOutlet weak var centerCenterImage: UIImageView!
    @IBOutlet weak var rightCenterImage: UIImageView!
    @IBOutlet weak var leftBottomImage: UIImageView!
    @IBOutlet weak var centerBottomImage: UIImageView!
    @IBOutlet weak var rightBottomImage: UIImageView!
    @IBOutlet weak var turnLabel: UILabel!
    
    private var turn: Int = 0
    private var totalMoves = 0
    private var currentGameState: [[Int]] = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
    private var isGameOver = false
    var playerOne: String = ""
    var playerTwo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGesture(imageView: leftTopImage)
        setTapGesture(imageView: centerTopImage)
        setTapGesture(imageView: rightTopImage)
        setTapGesture(imageView: leftCenterImage)
        setTapGesture(imageView: centerCenterImage)
        setTapGesture(imageView: rightCenterImage)
        setTapGesture(imageView: leftBottomImage)
        setTapGesture(imageView: centerBottomImage)
        setTapGesture(imageView: rightBottomImage)
        turnLabel.text = getActiveTurn()
    }
    
    private func getActiveTurn() -> String {
        var labelText = String("Your move: ")
        if turn == 0 {
            labelText.append(playerOne)
            labelText.append("(O)")
        } else {
            labelText.append(playerTwo)
            labelText.append("(X)")
        }
        return labelText
    }
    
    private func updatePlayerSettings(imageView: UIImageView) {
        imageView.alpha = 1.0
        if turn == 0 {
            imageView.image = UIImage(named: "circle.png")
            currentGameState[getPositionX(tag: imageView.tag)][getPositionY(tag: imageView.tag)] = 100
            turn = 1
        } else {
            imageView.image = UIImage(named: "close.png")
            currentGameState[getPositionX(tag: imageView.tag)][getPositionY(tag: imageView.tag)] = 200
            turn = 0
        }
        turnLabel.text = getActiveTurn()
    }
    
    private func setTapGesture(imageView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    private func getPositionX(tag: Int) -> Int {
        return switch tag {
        case 1,2,3:
            0
        case 4,5,6:
            1
        case 7,8,9:
            2
        default:
            -1
        }
    }
    
    private func getPositionY(tag: Int) -> Int {
        return switch tag {
        case 1,4,7:
            0
        case 2,5,8:
            1
        case 3,6,9:
            2
        default:
            -1
        }
    }
    
    private func validateTopRow(value: Int) -> Bool {
        return currentGameState[0][0] == value && currentGameState[0][1] == value && currentGameState[0][2] == value
    }
    
    private func validateMiddleRow(value: Int) -> Bool {
        return currentGameState[1][0] == value && currentGameState[1][1] == value && currentGameState[1][2] == value
    }
    
    private func validateBottomRow(value: Int) -> Bool {
        return currentGameState[2][0] == value && currentGameState[2][1] == value && currentGameState[2][2] == value
    }
    
    private func validateLeftColumn(value: Int) -> Bool {
        return currentGameState[0][0] == value && currentGameState[1][0] == value && currentGameState[2][0] == value
    }
    
    private func validateMiddleColumn(value: Int) -> Bool {
        return currentGameState[0][1] == value && currentGameState[1][1] == value && currentGameState[2][1] == value
    }
    
    private func validateRightColumn(value: Int) -> Bool {
        return currentGameState[0][2] == value && currentGameState[1][2] == value && currentGameState[2][2] == value
    }
    
    private func validateRightToLeft(value: Int) -> Bool {
        return currentGameState[0][2] == value && currentGameState[1][1] == value && currentGameState[2][0] == value
    }

    private func validateLeftToRight(value: Int) -> Bool {
        return currentGameState[0][0] == value && currentGameState[1][1] == value && currentGameState[2][2] == value
    }
    
    private func showGameResult(didPlayerWin: Bool) {
        var labelText = if didPlayerWin { String("Winner: ") } else { String("It's a tie") }
        if didPlayerWin {
            if turn == 1 {
                labelText.append(playerOne)
                labelText.append("(O)!")
            } else {
                labelText.append(playerTwo)
                labelText.append("(X)!")
            }
        }
        turnLabel.text = labelText
        showGameResultAlert(didPlayerWin: didPlayerWin)
    }
    
    private func resetGameBoard() {
        isGameOver = false
        turn = 0
        totalMoves = 0
        currentGameState = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
        turnLabel.text = getActiveTurn()
        resetBoardImage(imageView: leftTopImage)
        resetBoardImage(imageView: centerTopImage)
        resetBoardImage(imageView: rightTopImage)
        resetBoardImage(imageView: leftCenterImage)
        resetBoardImage(imageView: centerCenterImage)
        resetBoardImage(imageView: rightCenterImage)
        resetBoardImage(imageView: leftBottomImage)
        resetBoardImage(imageView: centerBottomImage)
        resetBoardImage(imageView: rightBottomImage)
    }
    
    private func resetBoardImage(imageView: UIImageView) {
        imageView.image = UIImage(named: "dotted_square.png")
        imageView.alpha = 0.5
        imageView.tintColor = UIColor.label
    }
    
    private func showGameResultAlert(didPlayerWin: Bool) {
        var title = ""
        var message = ""
        if didPlayerWin {
            title = "Congratulations!"
            if turn == 1 {
                message = playerOne + " win this game"
            } else {
                message = playerTwo + " win this game"
            }
        } else {
            title = "Game Over!"
            message = "Good game!"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "New Game!", style: UIAlertAction.Style.default, handler: {_ in
            self.resetGameBoard()
        }))
        alert.addAction(UIAlertAction(title: "Exit", style: UIAlertAction.Style.cancel, handler: {_ in
            if (self.navigationController is NavigationController) {
                (self.navigationController as! NavigationController).popViewController(animated: true, validate: false)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func checkForWinner(lastMovePosition: [Int], lastMove: Int) {
        if totalMoves > 4 {
            var result = false
            switch lastMovePosition {
            case [0,0]:
                print("0,0")
                result = validateTopRow(value: lastMove) || validateLeftToRight(value: lastMove) || validateLeftColumn(value: lastMove)
            case [0,1]:
                print("0,1")
                result = validateMiddleColumn(value: lastMove) || validateTopRow(value: lastMove)
            case [0,2]:
                print("0,2")
                result = validateRightColumn(value: lastMove) || validateTopRow(value: lastMove) || validateRightToLeft(value: lastMove)
            case [1,0]:
                print("1,0")
                result = validateMiddleRow(value: lastMove) || validateLeftColumn(value: lastMove)
            case [1,1]:
                print("1,1")
                result = validateMiddleRow(value: lastMove) || validateMiddleColumn(value: lastMove)
            case [1,2]:
                print("1,2")
                result = validateRightColumn(value: lastMove) || validateMiddleRow(value: lastMove)
            case [2,0]:
                print("2,0")
                result = validateLeftColumn(value: lastMove) || validateRightToLeft(value: lastMove) || validateBottomRow(value: lastMove)
            case [2,1]:
                print("2,1")
                result = validateMiddleColumn(value: lastMove) || validateBottomRow(value: lastMove)
            case [2,2]:
                print("2,2")
                result = validateRightColumn(value: lastMove) || validateLeftToRight(value: lastMove) || validateBottomRow(value: lastMove)
            default:
                print("Not a valid option")
            }
            
            if !result && totalMoves == 9 {
                isGameOver = true
                showGameResult(didPlayerWin: result)
                //TODO showAlert and restart game
            }
            
            if result {
                isGameOver = true
                showGameResult(didPlayerWin: result)
                //TODO: showAlert and restart game
            }
        }
    }

    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let x = getPositionX(tag: imageView.tag)
        let y = getPositionY(tag: imageView.tag)
        let isTaken = currentGameState[x][y] >= 0
        if sender.state == .ended && !isTaken && !isGameOver {
            print("Image tapped")
            totalMoves += 1
            updatePlayerSettings(imageView: imageView)
            checkForWinner(lastMovePosition: [x,y], lastMove: currentGameState[x][y])
        }
    }
}
