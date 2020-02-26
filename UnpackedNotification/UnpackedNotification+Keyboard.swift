//
//  UnpackedNotification+Keyboard.swift
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

public typealias KeyboardNotificationValues = (curve: UIView.AnimationCurve, duration: TimeInterval, frameBegin: CGRect, frameEnd: CGRect)

fileprivate let unpackKeyboardUserInfo = { (userInfo: [AnyHashable: Any]) -> KeyboardNotificationValues? in
    guard
        let animationCurveIndex = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
        let animationCurve = UIView.AnimationCurve(rawValue: animationCurveIndex),
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
        let frameBegin = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
        let frameEnd = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    else {
        return nil
    }

    return (animationCurve, duration, frameBegin, frameEnd)
}

extension UIResponder {

    public static let keyboardWillShowUnpackedNotification =
        UnpackedNotification<KeyboardNotificationValues>(
            name: UIResponder.keyboardWillShowNotification,
            unpackUserInfo: unpackKeyboardUserInfo)

    public static let keyboardDidShowUnpackedNotification =
        UnpackedNotification<KeyboardNotificationValues>(
            name: UIResponder.keyboardDidShowNotification,
            unpackUserInfo: unpackKeyboardUserInfo)

    public static let keyboardWillHideUnpackedNotification =
        UnpackedNotification<KeyboardNotificationValues>(
            name: UIResponder.keyboardWillHideNotification,
            unpackUserInfo: unpackKeyboardUserInfo)

    public static let keyboardDidHideUnpackedNotification =
        UnpackedNotification<KeyboardNotificationValues>(
            name: UIResponder.keyboardDidHideNotification,
            unpackUserInfo: unpackKeyboardUserInfo)
}
