/*
 -----------------------------------------------------------------------------
 This source file is part of MedKit.
 
 Copyright 2016-2018 Jon Griffeth
 
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


// MARK: - MedKitCore
@_exported import enum     MedKitCore.Access
@_exported import class    MedKitCore.AnyCodable
@_exported import class    MedKitCore.AnyDecoder
@_exported import class    MedKitCore.AnyEncoder
@_exported import protocol MedKitCore.Device
@_exported import protocol MedKitCore.DeviceBrowser
@_exported import protocol MedKitCore.DeviceBrowserObserver
@_exported import class    MedKitCore.DeviceBrowserShared
@_exported import struct   MedKitCore.DeviceIdentity
@_exported import struct   MedKitCore.DeviceProfile
@_exported import class    MedKitCore.DeviceProxyNetCache
@_exported import protocol MedKitCore.DeviceObserver
@_exported import protocol MedKitCore.ProtocolPlugin
@_exported import class    MedKitCore.ProtocolPluginManager
@_exported import protocol MedKitCore.DeviceProxy
@_exported import class    MedKitCore.DeviceType
@_exported import enum     MedKitCore.MedKitError
@_exported import class    MedKitCore.NetPortFactory
@_exported import protocol MedKitCore.PortFactory
@_exported import class    MedKitCore.ProtocolType
@_exported import protocol MedKitCore.Resource
@_exported import struct   MedKitCore.ResourceProfile
@_exported import protocol MedKitCore.ResourceObserver
@_exported import class    MedKitCore.ResourceSubject
@_exported import protocol MedKitCore.Service
@_exported import struct   MedKitCore.ServiceProfile
@_exported import protocol MedKitCore.ServiceObserver
@_exported import class    MedKitCore.ServiceType
@_exported import class    MedKitCore.Sync

// MARK: - MedKitDomain
@_exported import protocol MedKitDomain.Account
@_exported import protocol MedKitDomain.AccountManager
@_exported import class    MedKitDomain.AccountManagerShared
@_exported import protocol MedKitDomain.AccountManagerObserver
@_exported import protocol MedKitDomain.Patient
@_exported import protocol MedKitDomain.PatientDirectory
@_exported import class    MedKitDomain.PatientDirectoryShared
@_exported import protocol MedKitDomain.PatientObserver
@_exported import struct   MedKitDomain.PatientProfile

// MARK: - MedKitAssignedNumbers
@_exported import          MedKitAssignedNumbers

public typealias Image = ImageV1
public typealias Name  = NameV1


// End of File
