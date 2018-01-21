/*
 -----------------------------------------------------------------------------
 This source file is part of MedKit.

 Copyright 2017-2018 Jon Griffeth

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
 */


import Foundation


public class LocationController: ResourceController, ResourceObserver {

    public typealias Value = LocationProtocolV1.Value

    // MARK: - Properties
    public weak var         delegate     : LocationControllerDelegate?
    public private(set) var location     : Value
    public private(set) var timeModified : TimeInterval

    // MARK: - Private
    private typealias LocationProtocol = LocationProtocolV1
    private typealias Notification     = LocationProtocolV1.Notification

    // MARK: - Initialiers

    /**
     Initialize instance.
     */
    override public init(for resource: Resource)
    {
        location     = Value()
        timeModified = 0

        super.init(for: resource)
    }

    // MARK: - ResourceController

    override public func start()
    {
        resource.addObserver(self) { error in
            self.delegate?.locationControllerDidStart(self)
        }
    }

    override public func stop()
    {
        resource.removeObserver(self) { error in
            self.delegate?.locationController(self, didStopForReason: error)
        }
    }

    // MARK: - Value Management

    public func readValue(completionHandler completion: @escaping (Error?) -> Void)
    {
        let message = LocationProtocol.Method.ReadValue()

        resource.call(message: message) { reply, error in

            if error == nil, let reply = reply {
                do {
                    let update = try reply.decode(LocationProtocol.Method.ReadValue.Reply.self)

                    self.location     = update.value
                    self.timeModified = update.time.timeInterval
                }
                catch {

                }
            }

            completion(error)
        }
    }

    public func writeValue(location: Value, completionHandler completion: @escaping (Error?) -> Void)
    {
        let message = LocationProtocol.Method.WriteValue(args: location)

        resource.call(message: message) { reply, error in

            if error == nil, let reply = reply {
                do {
                    let update = try reply.decode(LocationProtocol.Method.WriteValue.Reply.self)

                    self.location     = update.value
                    self.timeModified = update.time.timeInterval
                }
                catch {

                }
            }

            completion(error)
        }
    }

    // MARK: - ResourceObserver

    /**
     Decode resource notifications.

     - Parameters:
        - resource:
        - decoder:
     */
    public func resource(_ resource: Resource, didNotifyWith notification: AnyCodable)
    {
        do {
            let container = try notification.decoder.container(keyedBy: Notification.CodingKeys.self)
            let type      = try container.decode(Notification.NotificationType.self, forKey: .type)

            switch type {
            case .didUpdate :
                let update = try container.decode(Notification.DidUpdate.Args.self, forKey: .args)

                location     = update.value
                timeModified = update.time.timeInterval

                delegate?.locationControllerDidUpdate(self)
            }
        }
        catch {
            
        }
    }

}


// End of File


