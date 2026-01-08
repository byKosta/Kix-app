import SwiftUI

struct LoginLogoView: View {
    var body: some View {
        Image("LoginLogo") // Assuming you have an image named "LoginLogo" in your assets
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
    }
}

struct LoginLogoView_Previews: PreviewProvider {
    static var previews: some View {
        LoginLogoView()
    }
}
