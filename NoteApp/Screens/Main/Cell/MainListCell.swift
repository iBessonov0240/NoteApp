import SwiftUI

struct MainListCell: View {

    // MARK: - Property

    let title: String?
    let description: String?
    let date: String?
    @State var completed: Bool

    // MARK: - View

    var body: some View {
        VStack {
            HStack(alignment: .top) {

                Image(completed ? "complete" : "incomplete")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 48)
                    .onTapGesture {
                        completed.toggle()
                    }

                VStack(alignment: .leading, spacing: 6) {
                    Text(title ?? "")
                        .foregroundColor(completed ? ColorManager().whiteAlpha : ColorManager().white)
                        .strikethrough(completed, color: ColorManager().whiteAlpha)
                        .font(.system(size: 16, weight: .bold))
                        .padding(.leading, 8)
                        .padding(.top, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(description ?? "")
                        .foregroundColor(completed ? ColorManager().whiteAlpha : ColorManager().white)
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(2)
                        .padding(.leading, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(date ?? "")
                        .foregroundColor(completed ? ColorManager().whiteAlpha : ColorManager().white)
                        .font(.system(size: 12, weight: .regular))
                        .padding(.bottom, 12)
                        .padding(.leading, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.leading, 20)

            Divider()
                .background(Color.gray)
                .padding(.leading, 20)
        }
        .background(ColorManager().background)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainListCell(title: "Title", description: "Some text", date: "02/12/24", completed: false)
}
