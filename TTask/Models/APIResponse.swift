
import Foundation

struct APIResponse: Codable {
    let success: Bool
    let message: String
    let userId: String?
}
