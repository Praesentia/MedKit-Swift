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
 Waveform stream cache.
 */
public class WaveformStreamCache {

    // MARK: - Properties
    public static let main = WaveformStreamCache()

    // MARK: - Private
    private struct Entry {
        unowned let reader: WaveformReader
        
        init(_ reader: WaveformReader)
        {
            self.reader = reader
        }
    }
    
    private var channel = [UUID : Entry]()

    // MARK: - Initializers

    /**
     Initialize instance.
     */
    private init()
    {
    }

    // MARK: - Cache Management
    
    /**
     Find or instantiate a waveform reader for resource.
     */
    public func findReader(for resource: Resource) -> WaveformReader?
    {
        var reader = channel[resource.identifier]?.reader
        
        if reader == nil {
            reader = WaveformReader(from: resource)
            channel[resource.identifier] = Entry(reader!)
        }
        
        return reader
    }
    
    /**
     Remove waveform reader from cache.
     */
    public func removeReader(with identifier: UUID)
    {
        channel[identifier] = nil
    }
    
}


// End of File
