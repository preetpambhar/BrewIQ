
import Foundation
import HealthKit

class HealthManager {
    let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }

        let calorieType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        healthStore.requestAuthorization(toShare: [], read: [calorieType]) { success, error in
            completion(success, error)
        }
    }

    func fetchCaloriesBurned(completion: @escaping (Double?, Error?) -> Void) {
        guard let calorieType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completion(nil, nil)
            return
        }

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let sum = result?.sumQuantity() else {
                completion(nil, error)
                return
            }
            
            let calories = sum.doubleValue(for: HKUnit.kilocalorie())
            completion(calories, nil)
        }

        healthStore.execute(query)
        if HKHealthStore.isHealthDataAvailable() {
            print("✅ HealthKit is available!")
        } else {
            print("❌ HealthKit is NOT available on this device.")
        }
    }
    
    func getCalories(completion: @escaping (Double) -> Void){
        //var userCalories : Double?
                // Fetch calories burned today
                fetchCaloriesBurned { calories, error in
                    if let calories = calories {
                        print("Calories burned today: \(calories) kcal")
                        completion(calories)
                    } else {
                        print("Error fetching calories: \(String(describing: error?.localizedDescription))")
                        completion(0.0)
                    }
                }
    }
    
//    func getCalories() -> Double{
//      fetchCaloriesBurned{ success, error in
//            if (success != nil) {
//                print("HealthKit authorization granted!")
//                
//                // Fetch calories burned today
//                self.fetchCaloriesBurned { calories, error in
//                    if let calories = calories {
//                        print("Calories burned today: \(calories) kcal")
//                    } else {
//                        print("Error fetching calories: \(String(describing: error?.localizedDescription))")
//                    }
//                }
//            } else {
//                print("HealthKit authorization denied.")
//            }
//        }
//    }
}
