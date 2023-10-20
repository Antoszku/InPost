import SwiftUI

extension PackListView.PackCell {
    struct HeaderValueLabel: View {
        let header: String
        let value: String
        let valueFont: Font.Montserrat

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text(header).appFont(.semiBold, size: 11).foregroundColor(ColorPalette.headerText)
                Text(value).appFont(valueFont, size: 15).foregroundColor(ColorPalette.text)
            }
        }
    }
}
