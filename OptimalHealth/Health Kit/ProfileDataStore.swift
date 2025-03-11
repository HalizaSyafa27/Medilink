/**
 * Copyright © 2018 Oditek. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import HealthKit

class ProfileDataStore {

  class func getAgeSexAndBloodType() throws -> (age: Int,
                                                biologicalSex: HKBiologicalSex,
                                                bloodType: HKBloodType) {
    
    let healthKitStore = HKHealthStore()
                                                    
    
    do {
      
      //1. This method throws an error if these data are not available.
        var birthdayComponents : DateComponents?
        if #available(iOS 10.0, *) {
            birthdayComponents =  try healthKitStore.dateOfBirthComponents()
        } else {
            // Fallback on earlier versions
        }
      let biologicalSex =       try healthKitStore.biologicalSex()
      let bloodType =           try healthKitStore.bloodType()
      
      //2. Use Calendar to calculate age.
      let today = Date()
      let calendar = Calendar.current
      let todayDateComponents = calendar.dateComponents([.year],
                                                        from: today)
      let thisYear = todayDateComponents.year!
      let age = thisYear - (birthdayComponents?.year!)!
      
      //3. Unwrap the wrappers to get the underlying enum values.
      let unwrappedBiologicalSex = biologicalSex.biologicalSex
      let unwrappedBloodType = bloodType.bloodType
        
      
      return (age, unwrappedBiologicalSex, unwrappedBloodType)
    }
  }
  
  class func getMostRecentSample(for sampleType: HKSampleType,
                                 completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
    
    //1. Use HKQuery to load the most recent samples.
    let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                          end: Date(),
                                                          options: .strictEndDate)
    
    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                          ascending: false)
    
    let limit = 1
    
    let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                    predicate: mostRecentPredicate,
                                    limit: limit,
                                    sortDescriptors: [sortDescriptor]) { (query, samples, error) in
    
      //2. Always dispatch to the main thread when complete.
      DispatchQueue.main.async {
        
        guard let samples = samples,
              let mostRecentSample = samples.first as? HKQuantitySample else {
                
              completion(nil, error)
              return
        }
        
        completion(mostRecentSample, nil)
      }
    }
    
    HKHealthStore().execute(sampleQuery)
  }
  
   class func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let healthKitStore = HKHealthStore()
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
    
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
    
        healthKitStore.execute(query)
    }
    
    class func getTodaysFlightClimbed(completion: @escaping (Double) -> Void) {
        let healthKitStore = HKHealthStore()
        let fCmilbedQuantityType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: fCmilbedQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthKitStore.execute(query)
    }
    
    class func getTodaysWalkingAndRunningDistance(completion: @escaping (Double) -> Void) {
        let healthKitStore = HKHealthStore()
        let walkingrunningType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: walkingrunningType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.meter()))
        }
        
        healthKitStore.execute(query)
    }
    
    class func getFatPercentage(completion: @escaping (Double) -> Void) {
        
        let healthKitStore = HKHealthStore()
        let bodyFatPercentageType = HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: bodyFatPercentageType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthKitStore.execute(query)
    }
    class func getActiveEnergy(currentDate: Date ,completion: @escaping ((_ totalEnergy: Double) -> Void)) {
        let healthKitStore = HKHealthStore()
        let calendar = Calendar.current
        var totalBurnedEnergy = Double()
        let startOfDay = Int((currentDate.timeIntervalSince1970/86400)+1)*86400
        let startOfDayDate = Date(timeIntervalSince1970: Double(startOfDay))
        //   Get the start of the day
        let newDate = calendar.startOfDay(for: startOfDayDate)
        let startDate: Date = calendar.date(byAdding: Calendar.Component.day, value: -1, to: newDate)!
        
        //  Set the Predicates
        let predicate = HKQuery.predicateForSamples(withStart: Date() as Date, end: Date() as Date, options: .strictStartDate)
        
        //  Perform the Query
        let energySampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)
        
        let query = HKSampleQuery(sampleType: energySampleType!, predicate: predicate, limit: 0, sortDescriptors: nil, resultsHandler: {
            (query, results, error) in
            if results == nil {
                print("There was an error running the query: \(String(describing: error))")
            }
            
            DispatchQueue.main.async {
                
                for activity in results as! [HKQuantitySample]
                {
                    let calories = activity.quantity.doubleValue(for: HKUnit.kilocalorie())
                    totalBurnedEnergy = totalBurnedEnergy + calories
                }
                completion(totalBurnedEnergy)
            }
        })
        healthKitStore.execute(query)
    }
    
    class func retrieveSleepAnalysis() {
        let healthKitStore = HKHealthStore()
        // first, we define the object type we want
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // Use a sortDescriptor to get the recent data first
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
            
            // we create our query with a block completion to execute
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    
                    // something happened
                    return
                    
                }
                
                if let result = tmpResult {
                    
                    // do something with my data
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                            print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                            let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                            let minutes = (Int(seconds) / 60) % 60
                            let hours = Int(seconds) / 3600
                            print("Sleep time: \(hours)h \(minutes)m")
                            if value == "InBed"{
                                print("In bed: \(hours)h \(minutes)m")
                            }else{
                                print("Asleep: \(hours)h \(minutes)m")
                            }
                            
                        }
                    }
                }
            }
            
            // finally, we execute our query
            healthKitStore.execute(query)
        }
    }
    
    class func readHeartRateData() -> Void {
        let healthKitStore = HKHealthStore()
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        
        // SELECT bpm FROM HealthKitStore WHERE qtyTypeID = '.heartRate';
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) {
            (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            
            if let samples = samplesOrNil {
                
                for heartRateSamples in samples {
                    print("Heart rate: \(heartRateSamples)")
                }
                
            }
            else {
                print("No heart rate sample available.")
            }
            
        }
        
        // STEP 9.3: execute the query for heart rate data
        healthKitStore.execute(query)
        
    }
    
    class func readBloodPressureDatewise(){
        let healthKitStore = HKHealthStore()
         guard let type = HKQuantityType.correlationType(forIdentifier: HKCorrelationTypeIdentifier.bloodPressure),
        let systolicType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic),
        let diastolicType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic) else {

            return
        }
        
        let endDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -7, to: endDate, wrappingComponents: false)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: true)
        let sampleQuery = HKSampleQuery(sampleType: type, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor])
            { (sampleQuery, results, error ) -> Void in
            if let dataList = results as? [HKCorrelation] {
                for data in dataList
                {
                    if let data1 = data.objects(for: systolicType).first as? HKQuantitySample,
                        let data2 = data.objects(for: diastolicType).first as? HKQuantitySample {

                        let value1 = data1.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                        let value2 = data2.quantity.doubleValue(for: HKUnit.millimeterOfMercury())

                        print("Blood Pressure === \(data.startDate) \(value1) / \(value2)")
                    }
                }
            }
        }
        healthKitStore.execute(sampleQuery)
    }
    
    class func readHeartRateDatewise() {
        let calendar = Calendar.current

        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        // Start 14 days back, end with today
        let endDate = Date()
        let startDate = calendar.date(byAdding: .day, value: -14, to: endDate)!

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])

        // Set the anchor to exactly midnight
        let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!

        // Generate daily statistics
        var interval = DateComponents()
        interval.day = 1

        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: heartRateType,
                                                quantitySamplePredicate: predicate,
                                                options: .discreteAverage,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        // Set the results handler
        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else { return }

            for statistics in statsCollection.statistics() {
                guard let quantity = statistics.averageQuantity() else { continue }

                let beatsPerMinuteUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let value = quantity.doubleValue(for: beatsPerMinuteUnit)

                let df = DateFormatter()
                df.dateStyle = .medium
                df.timeStyle = .none
                print("On \(df.string(from: statistics.startDate)) the average heart rate was \(value) beats per minute")
            }
        }

        HKHealthStore().execute(query)
    }
    
    class func readHeartRateVariabilityDatewise() {
        let calendar = Calendar.current

        let heartRateVariabilityType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!

        // Start 14 days back, end with today
        let endDate = Date()
        let startDate = calendar.date(byAdding: .day, value: -14, to: endDate)!

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])

        // Set the anchor to exactly midnight
        let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!

        // Generate daily statistics
        var interval = DateComponents()
        interval.day = 1

        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: heartRateVariabilityType,
                                                quantitySamplePredicate: predicate,
                                                options: .discreteAverage,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        // Set the results handler
        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else { return }

            for statistics in statsCollection.statistics() {
                guard let quantity = statistics.averageQuantity() else { continue }

                let heartRateVariabilityUnit:HKUnit = HKUnit(from: "ms")
                                
                let value = Int(quantity.doubleValue(for: heartRateVariabilityUnit))

                let df = DateFormatter()
                df.dateStyle = .medium
                df.timeStyle = .none
                print("On \(df.string(from: statistics.startDate)) the average heart rate variability was \(value) ms")
            }
        }

        HKHealthStore().execute(query)
    }
    
    class func readEnergyBurnedDatewise() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
            else {
                return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 1

        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.hour = 0
        let anchorDate = calendar.date(from: anchorComponents)

        let stepsCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: dateComponents
        )

        // Set the results handler
        stepsCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            let startDate = calendar.date(byAdding: .day, value: -7, to: endDate, wrappingComponents: false)
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity(){
                        let date = statistics.startDate
                        let energyBurned = quantity.doubleValue(for: HKUnit.kilocalorie())
                        print("\(date): energy burned = \(energyBurned) cal")
                        //NOTE: If you are going to update the UI do it in the main thread
                        
                    }
                } //end block
            } //end if let
        }
        HKHealthStore().execute(stepsCumulativeQuery)
    }
    
    class func readFlightClimnbedDatewise() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .flightsClimbed)
            else {
                return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 1

        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.hour = 0
        let anchorDate = calendar.date(from: anchorComponents)

        let stepsCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: dateComponents
        )

        // Set the results handler
        stepsCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            let startDate = calendar.date(byAdding: .year, value: -7, to: endDate, wrappingComponents: false)
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity(){
                        let date = statistics.startDate
                        let flights = quantity.doubleValue(for: HKUnit.count())
                        print("\(date): Flight Climbed = \(flights)")
                        //NOTE: If you are going to update the UI do it in the main thread
                        
                    }
                } //end block
            } //end if let
        }
        HKHealthStore().execute(stepsCumulativeQuery)
    }
    
    class func readTempDatewise() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .bodyTemperature)
            else {
                return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 1

        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.hour = 0
        let anchorDate = calendar.date(from: anchorComponents)

        let stepsCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .discreteAverage, anchorDate: anchorDate!, intervalComponents: dateComponents
        )

        // Set the results handler
        stepsCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            let startDate = calendar.date(byAdding: .day, value: -7, to: endDate, wrappingComponents: false)
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.averageQuantity(){
                        let date = statistics.startDate
                        let energyBurned = quantity.doubleValue(for: HKUnit.degreeCelsius())
                        print("\(date): Temperature = \(energyBurned) celcius")
                        //NOTE: If you are going to update the UI do it in the main thread
                        
                    }
                } //end block
            } //end if let
        }
        HKHealthStore().execute(stepsCumulativeQuery)
    }
    
    class func readSleepDataDatewise() {
        let healthStore = HKHealthStore()
            
        // first, we define the object type we want
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        print("previousMonth === \(previousMonth)")
        let startOfDay = Calendar.current.startOfDay(for: Date())
        // we create a predicate to filter our data
        let predicate = HKQuery.predicateForSamples(withStart: Date(), end: Date.yesterday, options: .strictStartDate)
        

        // I had a sortDescriptor to get the recent data first
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        // we create our query with a block completion to execute
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 30, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            if error != nil {
                // handle error
                return
            }
            
            if let result = result {
                
                // do something with those data
                result
                    .compactMap({ $0 as? HKCategorySample })
                    .forEach({ sample in
                        guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                            return
                        }
                        
                        let isAsleep = sleepValue == .asleep
                        
                        print("Sleep data === \(sample.startDate) \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                    })
            }
        }

        // finally, we execute our query
        healthStore.execute(query)
    }
    
    class func sleepTime() {
        let healthStore = HKHealthStore()
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {

            let endDate = Calendar.current.date(byAdding: .day, value: -3, to: Date())
            let predicate = HKQuery.predicateForSamples(withStart: Date(), end: Date.yesterday, options: [])
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 3000, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                if let result = tmpResult {
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                                return
                            }
                            let isAsleep = sleepValue == .asleep
                            
                            print("Sleep data === \(sample.startDate) \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                        }
                    }
                }
            }

            healthStore.execute(query)
        }
    }
    
    //MARK: Write to Save Data
    class func saveBodyMassIndexSample(bodyMassIndex: Double, date: Date) {
      
      //1.  Make sure the body mass type exists
      guard let bodyMassIndexType = HKQuantityType.quantityType(forIdentifier: .bodyMassIndex) else {
        fatalError("Body Mass Index Type is no longer available in HealthKit")
      }
      
      //2.  Use the Count HKUnit to create a body mass quantity
      let bodyMassQuantity = HKQuantity(unit: HKUnit.count(),
                                        doubleValue: bodyMassIndex)
      
      let bodyMassIndexSample = HKQuantitySample(type: bodyMassIndexType,
                                                 quantity: bodyMassQuantity,
                                                 start: date,
                                                 end: date)
      
      //3.  Save the same to HealthKit
      HKHealthStore().save(bodyMassIndexSample) { (success, error) in
        
        if let error = error {
          print("Error Saving BMI Sample: \(error.localizedDescription)")
        } else {
          print("Successfully saved BMI Sample")
        }
      }
    }
    
    class func saveSteps(stepsCountValue: Int, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            fatalError("Step Count Type is no longer available in HealthKit")
        }
        
        let stepsCountQuantity = HKQuantity(unit: HKUnit.count(), doubleValue: Double(stepsCountValue))
        
        let stepsCountSample = HKQuantitySample(type: stepCountType, quantity: stepsCountQuantity, start: date, end: date)
        
        HKHealthStore().save(stepsCountSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Steps Count Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Steps Count Sample")
            }
        }
    }
    
    class func saveFlightClimbed(flightClimbed: Int, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let flightClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
            fatalError("Flight Climbed Type is no longer available in HealthKit")
        }
        
        let flightClimbedQuantity = HKQuantity(unit: HKUnit.count(), doubleValue: Double(flightClimbed))
        
        let flightClimbedSample = HKQuantitySample(type: flightClimbedType, quantity: flightClimbedQuantity, start: date, end: date)
        
        HKHealthStore().save(flightClimbedSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Flight Climbed Count Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Flight Climbed Count Sample")
            }
        }
    }
    
    class func saveWalkingAndRunningDistance(distanceWalkingRunning: Double, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let walkingRunningDistanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            fatalError("Walking Running Distance Type is no longer available in HealthKit")
        }
        
        let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: distanceWalkingRunning*1000.0)
        
        let walkingrunningSample = HKQuantitySample(type: walkingRunningDistanceType, quantity: distanceQuantity, start: date, end: date)
        
        HKHealthStore().save(walkingrunningSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Walking Running Distance Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Walking Running Distance Sample")
            }
        }
    }
    
    class func saveFatPercentage(fatPercentage: Double, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let fatPercentageType = HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage) else {
            fatalError("Fat Percentage Type is no longer available in HealthKit")
        }
        
        let fatPercentageQuantity = HKQuantity(unit: HKUnit.percent(), doubleValue: Double(fatPercentage/100.0))
        
        let fatPercentageSample = HKQuantitySample(type: fatPercentageType, quantity: fatPercentageQuantity, start: date, end: date)
        
        HKHealthStore().save(fatPercentageSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Fat Percentage Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Fat Percentage Sample")
            }
        }
    }
    
    class func saveEnergyBurned(energyBurned: Int, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            fatalError("Fat Percentage Type is no longer available in HealthKit")
        }
        
        let energyBurnedQuantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: Double(energyBurned))
        
        let energyBurnedSample = HKQuantitySample(type: energyBurnedType, quantity: energyBurnedQuantity, start: date, end: date)
        
        HKHealthStore().save(energyBurnedSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Active Energy Burned Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Active Energy Burned Sample")
            }
        }
    }
    
    class func saveWeight(bodyMass: Int, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let bodyMassType = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
            fatalError("Body Mass Type is no longer available in HealthKit")
        }
        
        let bodyMassQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .kilo), doubleValue: Double(bodyMass))
        
        let bodyMassSample = HKQuantitySample(type: bodyMassType, quantity: bodyMassQuantity, start: date, end: date)
        
        HKHealthStore().save(bodyMassSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Body Mass Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Body Mass Sample")
            }
        }
    }
    
    class func saveHeight(height: Int, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let heightType = HKQuantityType.quantityType(forIdentifier: .height) else {
            fatalError("Height Type is no longer available in HealthKit")
        }
        
        let heightQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: Double(Double(height)/100.0))
        
        let heightSample = HKQuantitySample(type: heightType, quantity: heightQuantity, start: date, end: date)
        
        HKHealthStore().save(heightSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Height Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Height Sample")
            }
        }
    }
    
    class func saveHeartRate(heartRate: Double, date: Date) {
      
      //1.  Make sure the body mass type exists
      guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
        fatalError("Heart Rate Type is no longer available in HealthKit")
      }
      
      //2.  Use the Count HKUnit to create a body mass quantity
        let heartRateQuantity = HKQuantity(unit: HKUnit.count().unitDivided(by: HKUnit.minute()),
                                        doubleValue: heartRate)
      
      let heartRateSample = HKQuantitySample(type: heartRateType,
                                                 quantity: heartRateQuantity,
                                                 start: date,
                                                 end: date)
      
      //3.  Save the same to HealthKit
      HKHealthStore().save(heartRateSample) { (success, error) in
        
        if let error = error {
          print("Error Saving Heart Rate Sample: \(error.localizedDescription)")
        } else {
          print("Successfully saved Heart Rate Sample")
        }
      }
    }
    
    class func saveHeartRateVariability(heartRateVariability: Double, date: Date) {
      
      //1.  Make sure the body mass type exists
      guard let heartRateVariabilityType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else {
        fatalError("Heart Rate Variability Type is no longer available in HealthKit")
      }
      
      //2.  Use the Count HKUnit to create a body mass quantity
        let heartRateVariabilityQuantity = HKQuantity(unit: HKUnit(from: "ms"),
                                        doubleValue: heartRateVariability)
      
      let heartRateVariabilitySample = HKQuantitySample(type: heartRateVariabilityType,
                                                 quantity: heartRateVariabilityQuantity,
                                                 start: date,
                                                 end: date)
      
      //3.  Save the same to HealthKit
      HKHealthStore().save(heartRateVariabilitySample) { (success, error) in
        
        if let error = error {
          print("Error Saving Heart Rate Variability Sample: \(error.localizedDescription)")
        } else {
          print("Successfully saved Heart Rate Variability Sample")
        }
      }
    }
    
    class func saveBodyTemperature(temp: Double, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let bodyTemperatureType = HKQuantityType.quantityType(forIdentifier: .bodyTemperature) else {
            fatalError("Body Temperature Type is no longer available in HealthKit")
        }
        
        let bodyTemperatureQuantity = HKQuantity(unit: HKUnit.degreeCelsius(), doubleValue: temp)
        
        let bodyTemperatureSample = HKQuantitySample(type: bodyTemperatureType, quantity: bodyTemperatureQuantity, start: date, end: date)
        
        HKHealthStore().save(bodyTemperatureSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Body Temperature Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Body Temperature Sample")
            }
        }
    }
    
    class func saveBloodPressureMeasurement(systolic: Int, diastolic: Int, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let systolicType = HKQuantityType.quantityType(forIdentifier: .bloodPressureSystolic) else {
            fatalError("Systolic Type is no longer available in HealthKit")
        }
        let systolicQuantity = HKQuantity(unit: HKUnit.millimeterOfMercury(), doubleValue: Double(systolic))
        let systolicSample = HKQuantitySample(type: systolicType, quantity: systolicQuantity, start: date, end: date)
        
        guard let diastolicType = HKQuantityType.quantityType(forIdentifier: .bloodPressureDiastolic) else {
            fatalError("Diastolic Type is no longer available in HealthKit")
        }
        let diastolicQuantity = HKQuantity(unit: HKUnit.millimeterOfMercury(), doubleValue: Double(diastolic))
        let diastolicSample = HKQuantitySample(type: diastolicType, quantity: diastolicQuantity, start: date, end: date)
        
        guard let bpCorrelationType = HKCorrelationType.correlationType(forIdentifier: .bloodPressure) else {
            fatalError("Blood Pressure Type is no longer available in HealthKit")
        }
        let bpCorrelationObjects: Set<HKSample> = [systolicSample, diastolicSample]
        let bloodPressureSample = HKCorrelation(type: bpCorrelationType , start: date, end: date, objects: bpCorrelationObjects)
        
        HKHealthStore().save(bloodPressureSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Blood Pressure Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Blood Pressure Sample")
            }
        }
    }
    
    class func saveBloodGlucoseMeasurement(bloodGlucose: Double, date: Date, completion: @escaping (Error?) -> Swift.Void) {
        guard let bloodGlucoseType = HKQuantityType.quantityType(forIdentifier: .bloodGlucose) else {
            fatalError("Blood Glucose Type is no longer available in HealthKit")
        }
        
        let bloodGlucoseQuantity = HKQuantity(unit: HKUnit(from: "mg/dL"), doubleValue: bloodGlucose)
        
        let bloodGlucoseSample = HKQuantitySample(type: bloodGlucoseType, quantity: bloodGlucoseQuantity, start: date, end: date)
        
        HKHealthStore().save(bloodGlucoseSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Blood Glucose Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Blood Glucose Sample")
            }
        }
    }
    
    class func saveTotalSleepData(sleepAnalysis: Int, startDate: Date, endDate: Date) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            fatalError("Sleep Analysis Type inBed is no longer available in HealthKit")
        }
        
        var sleepInBed = sleepAnalysis
        sleepInBed = HKCategoryValueSleepAnalysis.inBed.rawValue
        
        let inBedSample = HKCategorySample(type: sleepType, value: sleepInBed, start: startDate, end: endDate)
        
        HKHealthStore().save(inBedSample) { (success, error) in
            if let error = error {
                print("Error Saving Sleep Analysis inBed Sample: \(error.localizedDescription)")
            } else {
                print("Successfully saved Sleep Analysis inBed Sample")
            }
        }
        
    }
    
    class func saveDeepSleepData(sleepAnalysis: Int, startDate: Date, endDate: Date) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            fatalError("Sleep Analysis Type asleep is no longer available in HealthKit")
        }
        
        var asleep = sleepAnalysis
        asleep = HKCategoryValueSleepAnalysis.asleep.rawValue
        
        let asleepSample = HKCategorySample(type: sleepType, value: asleep, start: startDate, end: endDate)
        
        HKHealthStore().save(asleepSample) { (success, error) in
            if let error = error {
                print("Error Saving Sleep Analysis asleep Sample: \(error.localizedDescription)")
            } else {
                print("Successfully saved Sleep Analysis asleep Sample")
            }
        }
    }
    
    //MARK: Get weekly count data
    class func getStepCount(type: String, duration: Int, completion:@escaping (_ count: [StepsBO])-> Void){

        guard let sampleType = HKObjectType.quantityType(forIdentifier: .stepCount)
            else {
                return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }
        
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }

        let stepsCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: dateComponents
        )

        // Set the results handler
        stepsCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
                startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                 startDate = calendar.startOfYear(Date())
            }else{//weekly
                startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
                startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrSteps = [StepsBO]()
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity(){
                        let sdate = statistics.startDate.setTime(hour: 0, min: 0, sec: 0)
                        let edate = statistics.endDate.setTime(hour: 0, min: 0, sec: 0)
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        print("start date= \(sdate): ssteps = \(steps) end date= \(edate)")
                        let stepsBo = StepsBO()
                        
                        stepsBo.startDate = AppConstant.formattedDate(date: sdate!, withFormat: StringConstant.dateFormatter13, ToFormat: StringConstant.dateFormatter9)!
                        stepsBo.endDate = AppConstant.formattedDate(date: edate!, withFormat: StringConstant.dateFormatter13, ToFormat: StringConstant.dateFormatter9)!
                        print("start date= \(stepsBo.startDate): ssteps = \(steps) end date= \(stepsBo.endDate)")
                        stepsBo.value = Int(steps)
                        arrSteps.append(stepsBo)
                    }
                } //end block
                 completion(arrSteps)
            } //end if let
        }
        HKHealthStore().execute(stepsCumulativeQuery)
    }
    
    class func getWalkingRunningDistance(type: String, duration: Int, completion:@escaping (_ count: [WalkingRunningDistanceBO])-> Void){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
            else {
                return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }

        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }
        
        let cumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: dateComponents
        )

        // Set the results handler
        cumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
               startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                startDate = calendar.startOfYear(Date())
            }else{//weekly
               startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
               startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrDistance = [WalkingRunningDistanceBO]()
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity(){
                        let sdate = statistics.startDate
                        let edate = statistics.endDate
                        let totaldistance = quantity.doubleValue(for: HKUnit.meter())
                        let strDistance = String(format: "%.02f", totaldistance/1000.0)
                        print("start date = \(sdate): Walking Running Distance = \(strDistance) km end date = \(edate)")
                        let distanceBo = WalkingRunningDistanceBO()
                        distanceBo.startDate = sdate
                        distanceBo.endDate = edate
                        distanceBo.distanceInKm = totaldistance/1000.0
                        arrDistance.append(distanceBo)
                        
                    }
                } //end block
                completion(arrDistance)
            } //end if let
        }
        HKHealthStore().execute(cumulativeQuery)
    }
    
    class func getHeartRate(type: String, duration: Int, completion:@escaping (_ count: [HeartRateBo])-> Void) {
        guard let sampleHeartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)
            else {
                return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }
        
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }
        
        
        let heartRateCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleHeartRateType, quantitySamplePredicate: nil, options: .discreteAverage, anchorDate: anchorDate!, intervalComponents: dateComponents
        )
        
        // Set the results handler
        heartRateCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
               startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                startDate = calendar.startOfYear(Date())
            }else{//weekly
               startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
               startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrHeartRate = [HeartRateBo]()
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.averageQuantity(){
                        let sdate = statistics.startDate
                        let edate = statistics.endDate
                        let beatsPerMinuteUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                        let value = quantity.doubleValue(for: beatsPerMinuteUnit)
                        print("start date = \(sdate): Heart Rate = \(value) beats per minute  end date = \(edate)")
                        
                        let heartRateBo = HeartRateBo()
                        heartRateBo.startDate = sdate
                        heartRateBo.endDate = edate
                        heartRateBo.heartRate = Int(value)
                        arrHeartRate.append(heartRateBo)
                        
                    }
                } //end block
                completion(arrHeartRate)
            } //end if let
        }
        HKHealthStore().execute(heartRateCumulativeQuery)
    }
    
    class func getHeartRateVariability(type: String, duration: Int, completion:@escaping (_ count: [HeartRateVariabilityBo])-> Void) {
        guard let sampleHeartRateVariabilityType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)
            else {
                return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }
        
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }
        
        
        let heartRateVariabilityCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleHeartRateVariabilityType, quantitySamplePredicate: nil, options: .discreteAverage, anchorDate: anchorDate!, intervalComponents: dateComponents
        )
        
        // Set the results handler
        heartRateVariabilityCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
               startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                startDate = calendar.startOfYear(Date())
            }else{//weekly
               startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
               startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrHeartRateVariability = [HeartRateVariabilityBo]()
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.averageQuantity(){
                        let sdate = statistics.startDate
                        let edate = statistics.endDate
                        let heartRateVariabilityUnit:HKUnit = HKUnit(from: "ms")
                        let value = Int(quantity.doubleValue(for: heartRateVariabilityUnit))
                        print("start date = \(sdate): Heart Rate Variability = \(value) ms  end date = \(edate)")
                        
                        let heartRateBo = HeartRateVariabilityBo()
                        heartRateBo.startDate = sdate
                        heartRateBo.endDate = edate
                        heartRateBo.heartRateVariability = Int(value)
                        arrHeartRateVariability.append(heartRateBo)
                        
                    }
                } //end block
                completion(arrHeartRateVariability)
            } //end if let
        }
        HKHealthStore().execute(heartRateVariabilityCumulativeQuery)
    }
    
    class func getFlightsClimbed(type: String, duration: Int, completion:@escaping (_ count: [FlightClimbCountBo])-> Void) {
        guard let sampleFlightsClimbedType = HKObjectType.quantityType(forIdentifier: .flightsClimbed)
            else {
                return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }
        
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }
        
        
        let stepsCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleFlightsClimbedType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: dateComponents
        )
        
        // Set the results handler
        stepsCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
               startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                startDate = calendar.startOfYear(Date())
            }else{//weekly
               startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
               startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrFlightClimb = [FlightClimbCountBo]()
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity(){
                        let sdate = statistics.startDate
                        let edate = statistics.endDate
                        let flights = quantity.doubleValue(for: HKUnit.count())
                        print("start date = \(sdate): FlightsClimbed = \(flights) Floors  end date = \(edate)")
                        
                        let flightClimbBo = FlightClimbCountBo()
                        flightClimbBo.startDate = sdate
                        flightClimbBo.endDate = edate
                        flightClimbBo.flightClimb = Int(flights)
                        arrFlightClimb.append(flightClimbBo)
                        
                    }
                } //end block
                completion(arrFlightClimb)
            } //end if let
        }
        HKHealthStore().execute(stepsCumulativeQuery)
    }
    
    class func getBodyTemperature(type: String, duration: Int, completion:@escaping (_ count: [BodyTemperatureBo])-> Void) {
        guard let sampleBodyTemperatureType = HKObjectType.quantityType(forIdentifier: .bodyTemperature)
            else {
                return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }
        
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }
        
        
        let bodyTemperatureCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleBodyTemperatureType, quantitySamplePredicate: nil, options: .discreteAverage, anchorDate: anchorDate!, intervalComponents: dateComponents
        )
        
        // Set the results handler
        bodyTemperatureCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
               startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                startDate = calendar.startOfYear(Date())
            }else{//weekly
               startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
               startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrBodyTemperature = [BodyTemperatureBo]()
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.averageQuantity(){
                        let sdate = statistics.startDate
                        let edate = statistics.endDate
                        let energyBurned = quantity.doubleValue(for: HKUnit.degreeCelsius())
                        print("start date = \(sdate): Temperature = \(energyBurned) celcius  end date = \(edate)")
                        
                        let flightClimbBo = BodyTemperatureBo()
                        flightClimbBo.startDate = sdate
                        flightClimbBo.endDate = edate
                        flightClimbBo.temperature = Int(energyBurned)
                        arrBodyTemperature.append(flightClimbBo)
                        
                    }
                } //end block
                completion(arrBodyTemperature)
            } //end if let
        }
        HKHealthStore().execute(bodyTemperatureCumulativeQuery)
    }
    
    class func getBloodPressure(type: String, duration: Int, completion:@escaping (_ count: [BloodPressureBo])-> Void) {
        guard let sampleType = HKQuantityType.correlationType(forIdentifier: HKCorrelationTypeIdentifier.bloodPressure),
        let systolicType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic),
        let diastolicType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)
            else {
                return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }
        
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }
        
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: true)
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 0, sortDescriptors: [sortDescriptor]) {sampleQuery, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
               startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                startDate = calendar.startOfYear(Date())
            }else{//weekly
               startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
               startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrBloodPressure = [BloodPressureBo]()
            if let myResults = results as? [HKCorrelation]{
                for data in myResults{
                    if let data1 = data.objects(for: systolicType).first as? HKQuantitySample,
                        let data2 = data.objects(for: diastolicType).first as? HKQuantitySample {
                        
                        let sdate = data.startDate
                        let edate = data.endDate
                        
                        let value1 = data1.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                        let value2 = data2.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                        print("start date = \(sdate): Blood Pressure ===  \(value1) / \(value2)  end date = \(edate)")
                        
                        let bloodPressureBo = BloodPressureBo()
                        bloodPressureBo.startDate = sdate
                        bloodPressureBo.endDate = edate
                        bloodPressureBo.bpSystolic = Int(value1)
                        bloodPressureBo.bpDiastolic = Int(value2)
                        arrBloodPressure.append(bloodPressureBo)
                    }
                }
                //end block
                completion(arrBloodPressure)
            } //end if let
        }
        HKHealthStore().execute(sampleQuery)
    }
    
    class func getBodyFatPercentage(type: String, duration: Int, completion:@escaping (_ count: [BodyFatBo])-> Void){
        guard let sampleBodyFatType = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)
            else {
                return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }

        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }
        
        let cumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleBodyFatType, quantitySamplePredicate: nil, options: .discreteAverage, anchorDate: anchorDate!, intervalComponents: dateComponents
        )

        // Set the results handler
        cumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
               startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                startDate = calendar.startOfYear(Date())
            }else{//weekly
               startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
               startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrBodyFat = [BodyFatBo]()
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.averageQuantity(){
                        let sdate = statistics.startDate
                        let edate = statistics.endDate
                        let fat = quantity.doubleValue(for: HKUnit.percent())
                        let strFat = String(format: "%.02f", fat * 100.0)
                        print("start date = \(sdate): BodyFatPercentage = \(strFat) % end date = \(edate)")
                        let fatBo = BodyFatBo()
                        fatBo.startDate = sdate
                        fatBo.endDate = edate
                        fatBo.bodyFatPercentage = fat*100.0
                        arrBodyFat.append(fatBo)
                        
                    }
                } //end block
                completion(arrBodyFat)
            } //end if let
        }
        HKHealthStore().execute(cumulativeQuery)
    }
    
    class func getActiveEnergyBurnedCount(type: String, duration: Int, completion:@escaping (_ count: [EnergyBurnedBo])-> Void){

        guard let sampleActiveEnergyBurnedType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
            else {
                return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        if type == "yearly"{
            dateComponents.year = 1
        }else if type == "monthly"{
            dateComponents.month = 1
        }else if type == "weekly"{
            dateComponents.day = 1
        }
        
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.month = 1
        anchorComponents.day = 1
        
        var anchorDate = calendar.date(from: anchorComponents)
        if type == "weekly"{
            let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
            anchorDate = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
        }

        let energyBurnedCumulativeQuery = HKStatisticsCollectionQuery(quantityType: sampleActiveEnergyBurnedType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: dateComponents
        )

        // Set the results handler
        energyBurnedCumulativeQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            var startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
            if type == "yearly"{
                startDate = calendar.date(byAdding: .year, value: duration, to: endDate, wrappingComponents: false)
            }else if type == "monthly"{
                 startDate = calendar.startOfYear(Date())
            }else{//weekly
                startDate = calendar.date(byAdding: .day, value: duration, to: endDate, wrappingComponents: false)
                startDate =  Calendar.current.startOfDay(for: startDate!)
            }
            var arrEnergyBurned = [EnergyBurnedBo]()
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity(){
                        let sdate = statistics.startDate
                        let edate = statistics.endDate
                        let energyBurned = quantity.doubleValue(for: HKUnit.kilocalorie())
                        print("start date= \(sdate): energy burned = \(energyBurned) cal end date= \(edate)")
                        let energyBurnedBo = EnergyBurnedBo()
                        energyBurnedBo.startDate = sdate
                        energyBurnedBo.endDate = edate
                        energyBurnedBo.energyBurned = energyBurned
                        arrEnergyBurned.append(energyBurnedBo)
                    }
                } //end block
                 completion(arrEnergyBurned)
            } //end if let
        }
        HKHealthStore().execute(energyBurnedCumulativeQuery)
    }
    
    
}

