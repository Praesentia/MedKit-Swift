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
 LocationController delegate.
 */
public protocol LocationControllerDelegate: class {

    /**
     Location controller did start.

     This method is called in response to ...
     */
    func locationControllerDidStart(_ controller: LocationController)

    /**
     Location controller did stop.

     This method is called in response to waveform capture being interrupted
     for any reason.
     */
    func locationController(_ controller: LocationController, didStopForReason reason: Error?)

    /**
     Location controller did update latency.
     */
    func locationControllerDidUpdate(_ controller: LocationController)

}


// End of File
