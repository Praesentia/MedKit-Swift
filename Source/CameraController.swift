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
 Camera Controller

 Placeholder
 */
public class CameraController: ResourceController {
    
    // MARK: - Properties
    public weak var  delegate : CameraControllerDelegate?
    public var       source   : CameraSource? { return reader?.stream }

    // MARK: - Private
    private var reader : CameraReader?
    
    // MARK: Initializers
    
    override public init(for resource: Resource)
    {
        super.init(for: resource)
    }
    
    // MARK: - ResourceController
    
    override public func start()
    {
        guard(reader == nil) else { return }

        let sync = Sync()

        if let reader = instantiateReader() {
            sync.incr()
            reader.start() { error in
                if error == nil {
                    self.enabled = true
                    self.reader  = reader
                }
                sync.decr(error)
            }
        }
        else {
            sync.fail(MedKitError.failed)
        }

        sync.close() { error in
            if error == nil {
                self.started()
            }
            else {
                self.stopped(for: error)
            }
        }
    }
    
    override public func stop()
    {
        if let reader = self.reader {
            reader.stop() { error in
                if error == nil {
                    self.enabled = false
                    self.reader  = nil
                }
                self.stopped(for: error)
            }
        }
    }

    // MARK: - Private

    private func instantiateReader() -> CameraReader?
    {
        return CameraReaderCache.shared.findReader(for: resource)
    }

    private func started()
    {
        if let delegate = self.delegate {
            DispatchQueue.main.async {
                delegate.cameraControllerDidStart(self)
            }
        }
    }
    
    private func stopped(for reason: Error?)
    {
        if let delegate = self.delegate {
            DispatchQueue.main.async {
                delegate.cameraController(self, didStopForReason: reason)
            }
        }
    }

}


// End of File
