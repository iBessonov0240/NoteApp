import SwiftUI

struct MainSearchBar: View {

    // MARK: - Properties

    @Binding var text: String

    private let textFont = Font.system(size: 17, weight: .regular)

    // MARK: - View

    var body: some View {

        TextField("", text: $text)
            .padding(.vertical, LayoutConstants.paddingVertical)
            .padding(.leading, LayoutConstants.leadingTextField)
            .background(ColorManager().gray)
            .foregroundColor(ColorManager().white)
            .cornerRadius(LayoutConstants.cornerRadiusTextField)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(ColorManager().whiteAlpha)
                        .padding(.leading, LayoutConstants.imageLeading)

                    if text.isEmpty {
                        Text("Search")
                            .font(textFont)
                            .foregroundColor(ColorManager().whiteAlpha)
                            .padding(.leading, LayoutConstants.searchLeading)
                    }

                    Spacer()

                    Button {
                        // TODO: - Add microphone action
                    } label: {
                        Image("microphone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: LayoutConstants.widthMicrophone, height: LayoutConstants.heightMicrophone)
                            .padding(LayoutConstants.paddingMicrophone)
                    }
                }
            )
            .padding(.horizontal, LayoutConstants.paddingHorizontal)
            .padding(.top, LayoutConstants.paddingVertical)
    }
}

#Preview {
    MainSearchBar(text: .constant("Text"))
}

// MARK: - Layouts

private struct LayoutConstants {
    static let paddingHorizontal: CGFloat = 20
    static let paddingVertical: CGFloat = 10
    static let paddingMicrophone: CGFloat = 8
    static let heightMicrophone: CGFloat = 22
    static let widthMicrophone: CGFloat = 17
    static let leadingTextField: CGFloat = 40
    static let cornerRadiusTextField: CGFloat = 10
    static let imageLeading: CGFloat = 6
    static let searchLeading: CGFloat = 3
}
