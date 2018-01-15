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


public class WaveformReader: ResourceObserver {
    
    // MARK: - Properties
    public let resource : Resource
    public let stream   = WaveformStream()

    // MARK: - Private
    private typealias WaveformProtocol = WaveformProtocolV1
    private typealias Notification     = WaveformProtocol.Notification

    private var       count: Int = 0

    // MARK: - Initialiers
    
    /**
     Initialize instance.
     */
    public init(from resource: Resource)
    {
        self.resource = resource
    }
    
    /**
     Deinitialize instance.
     
     Automatically removes the instance from the stream cache.
     */
    deinit
    {
        //assert(count == 0)
        
        WaveformStreamCache.main.removeReader(with: resource.identifier)
    }
    
    /**
     Start streaming waveform data.
     */
    public func start(completionHandler completion: @escaping (Error?) -> Void)
    {
        let sync = Sync()
        
        assert(count >= 0)
        
        count += 1
        if count == 1 {
            sync.incr()
            resource.addObserver(self) { error in
                sync.decr(error)
            }
        }
        
        sync.close(completionHandler: completion)
    }
    
    /**
     Stop streaming waveform data.
     */
    public func stop(completionHandler completion: @escaping (Error?) -> Void)
    {
        let sync = Sync()
        
        assert(count > 0)
        
        count -= 1
        if count == 0 { // TODO: race?
            sync.incr()
            resource.removeObserver(self) { error in
                sync.decr(error)
            }
        }
        
        sync.close(completionHandler: completion)
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
                let args = try container.decode(Notification.DidUpdate.Args.self, forKey: .args)
                stream.append(data: args.samples, at: args.index)
            }
        }
        catch let error {
            print("WaveformReader decoding error \(error).")
        }
    }
    
}


// End of File
