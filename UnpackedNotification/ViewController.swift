//
//  ViewController.swift
//  UnpackedNotification
//
//  Copyright (c) 2020 Rocket Insights, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!

    private var tokens: [UnpackedNotificationToken]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tokens = [
            // Remember to use [weak self] if self is referenced in any of the handler blocks below.

            NotificationCenter.default.addObserver(for: UIResponder.keyboardWillShowUnpackedNotification) { (_, duration: TimeInterval, frameBegin: CGRect, frameEnd: CGRect) in
                print("keyboardWillShow duration=\(duration) frameBegin=\(frameBegin) frameEnd=\(frameEnd)")
            },
            NotificationCenter.default.addObserver(for: UIResponder.keyboardDidShowUnpackedNotification) { (_, duration: TimeInterval, frameBegin: CGRect, frameEnd: CGRect) in
                print("keyboardDidShow duration=\(duration) frameBegin=\(frameBegin) frameEnd=\(frameEnd)")
            },
            NotificationCenter.default.addObserver(for: UIResponder.keyboardWillHideUnpackedNotification) { (_, duration: TimeInterval, frameBegin: CGRect, frameEnd: CGRect) in
                print("keyboardWillHide duration=\(duration) frameBegin=\(frameBegin) frameEnd=\(frameEnd)")
            },
            NotificationCenter.default.addObserver(for: UIResponder.keyboardDidHideUnpackedNotification) { (_, duration: TimeInterval, frameBegin: CGRect, frameEnd: CGRect) in
                print("keyboardDidHide duration=\(duration) frameBegin=\(frameBegin) frameEnd=\(frameEnd)")
            }
        ]
    }

    @IBAction func hideKeyboardTapped(_ sender: Any) {
        textField.resignFirstResponder()
    }
}
