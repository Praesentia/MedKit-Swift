/*
 -----------------------------------------------------------------------------
 This source file is part of MedKit.
 
 Copyright 2016-2017 Jon Griffeth
 
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


import Foundation;
import MedKitCore;
import MedKitDomain;


// MedKitCore
public typealias Access                  = MedKitCore.Access;
public typealias Authorization           = MedKitCore.Authorization;
public typealias Credentials             = MedKitCore.Credentials;
public typealias Device                  = MedKitCore.Device;
public typealias DeviceBrowser           = MedKitCore.DeviceBrowser;
public typealias DeviceBrowserObserver   = MedKitCore.DeviceBrowserObserver;
public typealias DeviceBrowserShared     = MedKitCore.DeviceBrowserShared;
public typealias DeviceCache             = MedKitCore.DeviceCache;
public typealias DeviceObserver          = MedKitCore.DeviceObserver;
public typealias DeviceProtocol          = MedKitCore.DeviceProtocol;
public typealias DeviceProtocols         = MedKitCore.DeviceProtocols;
public typealias DeviceProxy             = MedKitCore.DeviceProxy;
public typealias Identity                = MedKitCore.Identity;
public typealias JSON                    = MedKitCore.JSON;
public typealias JSONParser              = MedKitCore.JSONParser;
public typealias JSONWriter              = MedKitCore.JSONWriter;
public typealias MedKitError             = MedKitCore.MedKitError;
public typealias NetPortFactory          = MedKitCore.NetPortFactory;
public typealias NullAuthorization       = MedKitCore.NullAuthorization;
public typealias ObserverManager         = MedKitCore.ObserverManager;
public typealias PortFactory             = MedKitCore.PortFactory;
public typealias Principal               = MedKitCore.Principal;
public typealias Resource                = MedKitCore.Resource;
public typealias ResourceCache           = MedKitCore.ResourceCache;
public typealias ResourceCacheBase       = MedKitCore.ResourceCacheBase; // TODO: temporary
public typealias ResourceObserver        = MedKitCore.ResourceObserver;
public typealias SecurityManager         = MedKitCore.SecurityManager;
public typealias SecurityManagerShared   = MedKitCore.SecurityManagerShared;
public typealias Service                 = MedKitCore.Service;
public typealias ServiceObserver         = MedKitCore.ServiceObserver;
public typealias SharedSecret            = MedKitCore.SharedSecret;
public typealias Sync                    = MedKitCore.Sync;

// MedKitDomain
public typealias Account                 = MedKitDomain.Account;
public typealias AccountManager          = MedKitDomain.AccountManager;
public typealias AccountManagerShared    = MedKitDomain.AccountManagerShared;
public typealias AccountManagerObserver  = MedKitDomain.AccountManagerObserver;
public typealias Image                   = MedKitDomain.Image;
public typealias Name                    = MedKitDomain.Name;
public typealias Patient                 = MedKitDomain.Patient;
public typealias PatientDirectory        = MedKitDomain.PatientDirectory;
public typealias PatientDirectoryShared  = MedKitDomain.PatientDirectoryShared;
public typealias PatientObserver         = MedKitDomain.PatientObserver;

// Common JSON keys
public let KeyAccess               = MedKitCore.KeyAccess;
public let KeyContainer            = MedKitCore.KeyContainer;
public let KeyData                 = MedKitCore.KeyData;
public let KeyDescription          = MedKitCore.KeyDescription;
public let KeyIdentifier           = MedKitCore.KeyIdentifier;
public let KeyIdentity             = MedKitCore.KeyIdentity;
public let KeyIndex                = MedKitCore.KeyIndex;
public let KeyDiastolic            = MedKitCore.KeyDiastolic;
public let KeyMeasurement          = MedKitCore.KeyMeasurement;
public let KeyNotifications        = MedKitCore.KeyNotifications;
public let KeyPatients             = MedKitCore.KeyPatients;
public let KeyPhoto                = MedKitCore.KeyPhoto;
public let KeySchema               = MedKitCore.KeySchema;
public let KeySystolic             = MedKitCore.KeySystolic;
public let KeyUnit                 = MedKitCore.KeyUnit;

public func deviceTypeName(with identifier: UUID) -> String? { return MedKitCore.deviceTypeName(with: identifier); }


// End of File
