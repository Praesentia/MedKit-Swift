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


/**
 Placeholder
 */
public class CameraController: ResourceController, ResourceObserver {
    
    // MARK: - Properties
    public weak var         delegate : CameraControllerDelegate?
    public private(set) var source   : CameraSource?

    // MARK: - Private
    private enum NotificationKeys: CodingKey {
        case method
        case args
    }

    private enum Methods: Int, Codable {
        case didUpdate = 1
    }

    private enum DidUpdateArgs: CodingKey {
        case timeModified
    }
    
    // MARK: Initializers
    
    override public init(for resource: Resource)
    {
        super.init(for: resource)
    }
    
    // MARK: - ResourceController
    
    override public func start()
    {
        resource.addObserver(self) { error in
            self.delegate?.cameraControllerDidStart(self)
        }
    }
    
    override public func stop()
    {
        resource.removeObserver(self) { error in
            self.delegate?.cameraController(self, didStopForReason: error)
        }
    }

    // MARK: - Private
    
    private func stopped(for reason: Error?)
    {
        if let delegate = self.delegate {
            DispatchQueue.main.async {
                delegate.cameraController(self, didStopForReason: reason)
            }
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
    }

}


// End of File
