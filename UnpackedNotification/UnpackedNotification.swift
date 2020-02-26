//
//  UnpackedNotification.swift
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

import Foundation

public struct UnpackedNotification<UnpackedValues> {

    public var name: Notification.Name

    public var unpack: NotificationUnpackingBlock

    // MARK: - Unpack from Notification

    public typealias NotificationUnpackingBlock = (Notification) -> UnpackedValues?

    public init(name: Notification.Name, unpackNotification unpack: @escaping NotificationUnpackingBlock) {
        self.name = name
        self.unpack = unpack
    }

    // MARK: - Unpack from Notification userInfo dictionary

    public typealias UserInfoUnpackingBlock = ([AnyHashable: Any]) -> UnpackedValues?

    public init(name: Notification.Name, unpackUserInfo: @escaping UserInfoUnpackingBlock) {
        self.init(name: name, unpackNotification: { (notification) -> UnpackedValues? in
            guard let userInfo = notification.userInfo else {
                return nil
            }
            return unpackUserInfo(userInfo)
        })
    }
}

public class UnpackedNotificationToken {

    /// The token returned by `NotificationCenter`.
    fileprivate let token: NSObjectProtocol

    /// The `NotificationCenter` that the handler was registered with.
    fileprivate let center: NotificationCenter

    /// Creates a new `NotificationToken` with the specified values.
    fileprivate init(token: NSObjectProtocol, center: NotificationCenter) {
        self.token = token
        self.center = center
    }

    /// Deregisters the observer from the retained notification center using the retained token.
    deinit {
        center.removeObserver(token: self)
    }
}

extension NotificationCenter {

    public func addObserver<UnpackedValues>(for notificationType: UnpackedNotification<UnpackedValues>,
                                            object: Any? = nil,
                                            queue: OperationQueue? = nil,
                                            using block: @escaping (UnpackedValues) -> Void) -> UnpackedNotificationToken {

        let token = addObserver(forName: notificationType.name, object: object, queue: queue) { (notification) -> Void in
            guard let values = notificationType.unpack(notification) else {
                return
            }
            block(values)
        }
        return UnpackedNotificationToken(token: token, center: self)
    }

    public func removeObserver(token: UnpackedNotificationToken) {
        removeObserver(token.token)
    }
}
