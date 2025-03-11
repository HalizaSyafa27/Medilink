//
//  HealthKitInterface.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 14/11/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitInterface
{
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
            let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let steps = HKObjectType.quantityType(forIdentifier: .stepCount),
            let walkingDistance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            let flightClimbed = HKObjectType.quantityType(forIdentifier: .flightsClimbed),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
            let bodyFatPercentage = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage),
            let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
            let basalBodyTemp = HKObjectType.quantityType(forIdentifier: .basalBodyTemperature),
            let bodyTemp = HKObjectType.quantityType(forIdentifier: .bodyTemperature),
            let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
            var heartRateVariability = HKObjectType.quantityType(forIdentifier: .heartRate),
            let calBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            let bmi = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
            let bpSystolic = HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic),
            let bpDiastolic = HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic),
            let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
                
                completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }
        if #available(iOS 11.0, *) {
            heartRateVariability = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        }
        
        //3. Prepare a list of types you want HealthKit to read and write
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,height,bodyMass,
                                                        steps,walkingDistance,flightClimbed,
                                                        bodyFatPercentage,calBurned,
                                                        heartRate,heartRateVariability,
                                                        sleepAnalysis,bodyTemp,bpSystolic,bpDiastolic,
                                                        HKObjectType.workoutType()]
        
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       bloodType,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,bodyTemp,heartRate,heartRateVariability,calBurned,basalBodyTemp,bmi,bpSystolic,bpDiastolic,
                                                       bodyMass,steps,walkingDistance,flightClimbed,bodyFatPercentage,sleepAnalysis,
                                                       HKObjectType.workoutType()]
        
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
                                                completion(success, error)
        }
    }
    
    
}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
