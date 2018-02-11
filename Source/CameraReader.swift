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


class CameraReader {

    // MARK: - Properties
    let resource : Resource
    let stream   = CameraStream()

    // MARK: - Private
    private typealias CameraProtocol = CameraProtocolV1
    //private typealias Notification   = CameraProtocolV1.Notification

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
        CameraReaderCache.shared.removeReader(with: resource.identifier)
    }


    /**
     Start streaming waveform data.
     */
    func start(completionHandler completion: @escaping (Error?) -> Void)
    {
        let sync = Sync()

        assert(enabledCount >= 0)

        enabledCount += 1

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

        sync.close(completionHandler: completion)
    }

}


// End of File

