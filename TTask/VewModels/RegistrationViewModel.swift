
import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var age = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var registrationSuccess = false
    
    
    var isFormValid: Bool {
        !name.isEmpty &&
        isValidEmail(email) &&
        isValidAge(age)
    }
    
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Validation Methods
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$"#
        return email.range(of: emailRegex, options: .regularExpression) != nil
    }
    
    private func isValidAge(_ ageString: String) -> Bool {
        guard let ageValue = Int(ageString) else { return false }
        return ageValue >= 18 && ageValue <= 120
    }
    
    // MARK: - API Submission Method
    func submitRegistration() {
        
        errorMessage = nil
        isLoading = true
        registrationSuccess = false
        
        
        guard let userAge = Int(age) else {
            errorMessage = "Invalid age"
            isLoading = false
            return
        }
        
        let user = User(name: name, email: email, age: userAge)
        
        
        performRegistration(user: user)
    }
    
    private func performRegistration(user: User) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            
            
            self.registrationSuccess = true
            self.errorMessage = nil
            
            self.isLoading = false
        }
    }
}
