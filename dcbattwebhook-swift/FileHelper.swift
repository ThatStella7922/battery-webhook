//
//  FileHelper.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/17/23.
//

import Foundation

/**
 Gets the path of the data container that Battery Webhook has access to.
 
 - Returns: `URL`
 
 # Discussion
 WIll return something such as:
 ```
 file:///Users/Stella/Library/Developer/CoreSimulator/Devices/F03CD9C7-E201-47EB-ACBF-960EBD1C4DDD/data/Containers/Data/Application/C560575D-28C6-428C-9685-E6E2E8588E0F/Documents/
 ```
 This was on a simulator, but a valid path will be returned on real devices as well.
 */
func GetDataContainerPath() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

/**
 Builds a local data container path for a file you specify as arguments.
 
 # Usage
 Arguments:
 - fileName
 - fileExtension
 
 - Returns: `URL`
 
 # Discussion
 
 Example usage:
 ```
 BuildFilePathInDataContainer(fileName: "Example", fileExtension: "txt")
 ```
 
 WIll return something such as:
 ```
 file:///Users/Stella/Library/Developer/CoreSimulator/Devices/F03CD9C7-E201-47EB-ACBF-960EBD1C4DDD/data/Containers/Data/Application/C560575D-28C6-428C-9685-E6E2E8588E0F/Documents/Example.txt
 ```
 This was on a simulator, but a valid path will be returned on real devices as well.
 */
func BuildFilePathInDataContainer(fileName: String, fileExtension: String) -> URL {
    return GetDataContainerPath()
        .appendingPathComponent(fileName)
        .appendingPathExtension(fileExtension)
}

/**
 Takes a `Dictionary` and will attempt to convert it to raw JSON `Data`.
 
 - Warning: Do not use with this app's UserDefaults or any other `Dictionary` containing an NSDate. NSDate is incompatible with JSON conversion and will cause a crash.
 */
func DictionaryToJsonData(dictionary: Dictionary<String, Any>) -> Data {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        return jsonData
    } catch {
        print(error.localizedDescription)
    }
    
    return Data() // empty
}


/**
 Writes the contents of the input `Data` to the file at the specified `URL`
 
 Combine with `BuildFilePathInDataContainer` function to easily write files in the app's data container
 */
func WriteFile(data: Data, fileURL: URL) {
    do {
        try data.write(to: fileURL)
    } catch {
        print(error.localizedDescription)
    }
    
}
