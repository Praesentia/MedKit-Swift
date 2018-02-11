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
import MedKitAssignedNumbers


/**
 Waveform stream.
 */
public class WaveformStream: WaveformSource {
    
    // MARK: - Properties
    public private(set) var channel    = [Sample]()
    public private(set) var history    : TimeInterval = 30
    public var              latency    : TimeInterval { return latencyManager.value }
    public var              min        : Sample?      { calcMinMax(); return _min }
    public var              max        : Sample?      { calcMinMax(); return _max }
    public private(set) var offset     : Index = 0
    public private(set) var resolution : Index
    public private(set) var units      : UnitType
    
    // MARK: - Shadowed
    private var _min : Sample?
    private var _max : Sample?
    
    // MARK: - Private
    private var capacity       : Int
    private var stale          : Bool = true
    private let latencyManager : Latency

    // MARK: - Initializers
    
    /**
     Initialize instance.
     */
    public init(resolution: Index, units: UnitType, latency: Latency = Latency())
    {
        self.capacity       = Int(history * TimeInterval(resolution))
        self.resolution     = resolution
        self.units          = units
        self.latencyManager = latency
    }
    
    /**
     Append data.
     */
    public func append(segment: WaveformInterval)
    {
        latencyManager.update(for: segment.index.timeInterval(resolution: resolution))
        
        if channel.isEmpty {
            offset = segment.index
        }
        
        if segment.index != end {
            debugPrint("discontinuity \(segment.index - end)") // TODO
            channel = [Sample]()
            offset  = segment.index
        }
        
        channel += segment.samples
        stale    = true
        
        if channel.count > capacity {
            let n = channel.count - capacity
            
            channel.removeFirst(n)
            offset += Int64(n)
        }
    }

    // MARK: - Private

    /**
     Calculate min/max values.
     */
    private func calcMinMax()
    {
        if stale {
            _min = nil
            _max = nil
            
            for i in 0..<channel.count {
                if _min == nil || channel[i] < _min! {
                    _min = channel[i]
                }
                if _max == nil || channel[i] > _max! {
                    _max = channel[i]
                }
            }
            
            stale = false
        }
    }
    
}


// End of File
