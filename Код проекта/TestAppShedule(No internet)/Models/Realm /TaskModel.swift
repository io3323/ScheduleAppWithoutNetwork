import Foundation
import RealmSwift
class TaskModel:Object{
    @Persisted var taskDate:Date?
    @Persisted var taskName: String = "Unknown"
    @Persisted var taskDescription: String = "Unknown"
    @Persisted var taskColor: String = "76D6FF"
    @Persisted var taskReady: Bool = false
}
