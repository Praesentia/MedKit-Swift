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
 Waveform Reader
 */
class WaveformReader: ResourceObserver {
    
    // MARK: - Properties
    let resource : Resource
    let stream   = WaveformStream(resolution: 250, units: UnitType()) // TODO

    // MARK: - Private
    private typealias WaveformProtocol = WaveformProtocolV1
    private typealias Notification     = WaveformProtocolV1.Notification

    private var enabledCount: Int = 0

    // MARK: - Initializers
    
    /**
     Initialize instance.
     */
    init(from resource: Resource)
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
        
        WaveformReaderCache.shared.removeReader(with: resource.identifier)
    }
    
    /**
     Start streaming waveform data.
     */
    func start(completionHandler completion: @escaping (Error?) -> Void)
    {
        let sync = Sync()
        
        assert(enabledCount >= 0)
        
        enabledCount += 1
        if enabledCount == 1 {
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
    func stop(completionHandler completion: @escaping (Error?) -> Void)
    {
        let sync = Sync()
        
        assert(enabledCount > 0)
        
        enabledCount -= 1
        if enabledCount == 0 { // TODO: race?
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
        - notification:
     */
    func resource(_ resource: Resource, didNotify notification: AnyCodable)
    {
        do {
            let container = try notification.decoder.container(keyedBy: Notification.CodingKeys.self)
            let type      = try container.decode(Notification.NotificationType.self, forKey: .type)

            switch type {
            case .didUpdate :
                try didUpdate(from: container)
            }
        }
        catch let error {
            print("WaveformReader decoding error \(error).")
        }
    }

    // MARK: - Private

    /**
     Update from container.

     - Parameters:
        - container:
     */
    private func didUpdate(from container: KeyedDecodingContainer<Notification.CodingKeys>) throws
    {
        let args = try container.decode(Notification.DidUpdate.Args.self, forKey: .args)

        stream.append(segment: args)
    }
    
}


// End of File
