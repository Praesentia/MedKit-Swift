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

    // MARK: - Properties
    public weak var delegate    : LocationControllerDelegate?
    public var      description : String?            { return location?.description }
    public var      details     : LocationDetailsV1? { return location?.details}

    // MARK: - Private
    private typealias LocationProtocol = LocationProtocolV1
    private typealias Notification     = LocationProtocol.Notification

    private var location: LocationProtocol.Value?

    // MARK: - Initialiers

    /**
     Initialize instance.
     */
    override public init(for resource: Resource)
    {
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
                location = try container.decode(Notification.DidUpdate.Args.self, forKey: .args)
                delegate?.locationControllerDidUpdate(self)
            }
        }
        catch {
            
        }
    }

}


// End of File


