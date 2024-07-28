import SwiftUI

struct SettingsView: View {
    @State private var isDarkModeOn = true
    @State private var isCameraOn = true
    @State private var isMicrophoneOn = true
    @State private var isPhotoAccessOn = true
    @State private var isNotificationsOn = true
    
    var body: some View {
        VStack {
            Text("settings")
                .font(.title)
                .padding(.top, 20)
            
            Form {
                Section {
                    SettingsToggleRow(name: "Dark Mode", isOn: $isDarkModeOn)
                    SettingsToggleRow(name: "Camera", isOn: $isCameraOn)
                    SettingsToggleRow(name: "Microphone", isOn: $isMicrophoneOn)
                    SettingsToggleRow(name: "Photo Access", isOn: $isPhotoAccessOn)
                    SettingsToggleRow(name: "Notifications", isOn: $isNotificationsOn)
                }
                
                Section {
                    SettingsNavigationRow(name: "Accessibility")
                    SettingsNavigationRow(name: "Account Management")
                    SettingsNavigationRow(name: "Birthday")
                    SettingsNavigationRow(name: "Username")
                    SettingsNavigationRow(name: "Password")
                }
            }
            
            Button(action: {
                // Save changes action
            }) {
                Text("save changes")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 16)
            }
            .padding(.bottom, 16)
        }
    }
}

struct SettingsToggleRow: View {
    var name: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
    }
}

struct SettingsNavigationRow: View {
    var name: String
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Image(systemName: "gearshape.fill")
                .foregroundColor(.purple)
                .padding(8)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
