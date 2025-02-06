import SwiftUI

struct MainHeaderView: View {

    // MARK: - View
    
    var body: some View {

        Text("Задачи")
            .foregroundColor(ColorManager().white)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, LayoutConstants.paddingHorizontal)
            .padding(.top, LayoutConstants.paddingVertical)
    }
}

#Preview {
    MainHeaderView()
}

// MARK: - Layouts

private struct LayoutConstants {
    static let paddingHorizontal: CGFloat = 20
    static let paddingVertical: CGFloat = 10
}
