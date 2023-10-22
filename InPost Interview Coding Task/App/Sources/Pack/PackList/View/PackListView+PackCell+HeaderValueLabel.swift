import SwiftUI

extension PackListView.PackCell {
    struct HeaderValueLabel: View {
        let header: String
        let value: String
        let valueFont: Font.Montserrat
        var alignment: HorizontalAlignment = .leading

        var body: some View {
            VStack(alignment: alignment, spacing: 0) {
                Text(header).appFont(.semiBold, size: 11).foregroundColor(ColorPalette.headerText)
                Text(value).appFont(valueFont, size: 15).foregroundColor(ColorPalette.text)
            }
        }
    }
}
