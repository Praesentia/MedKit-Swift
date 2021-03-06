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
 Resource Controller
 */
open class ResourceController {

    // MARK: - Properties

    /**
     Enabled flag.
     */
    public internal(set) var enabled: Bool = false

    /**
     Resource reference.
     */
    public let resource: Resource

    // MARK: - Initialiers

    /**
     Initialize instance.
     */
    public init(for resource: Resource)
    {
        self.resource = resource
    }

    // MARK: - Basic Controls

    open func start()
    {
        fatalError()
    }

    open func stop()
    {
        fatalError()
    }

}


// End of File
