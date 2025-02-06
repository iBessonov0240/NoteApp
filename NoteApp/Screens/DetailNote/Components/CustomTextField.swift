import SwiftUI

struct CustomTextField: View {

    // MARK: - Properties

    var text: Binding<String>
        var font: Font

    // MARK: - View

    var body: some View {

        TextField("", text: text, axis: .vertical)
            .font(font)
            .foregroundColor(ColorManager().white)
            .frame(maxWidth: .infinity)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    } label: {
                        Text("Done")
                            .foregroundStyle(ColorManager().white)
                    }
                }
            }
    }
}

#Preview {
    CustomTextField(text: .constant("Text"), font: Font.system(size: 16))
}
