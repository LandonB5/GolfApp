// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "60791062c459bc88a9d1b9c2d80fc3a3"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Note.self)
  }
}