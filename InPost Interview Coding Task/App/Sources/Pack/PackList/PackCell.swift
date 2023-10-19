import SwiftUI

extension PackListView {
    struct PackCell: View {
        let presentable: PackPresentable

        var body: some View {
            VStack {
                VStack {
                    Text("NR PRZESYŁKI")
                    Text(presentable.id)
                }
                VStack {
                    Text("STATUS")
                    Text(presentable.status)
                }
                VStack {
                    Text("NADAWCA")
                    Text(presentable.sender)
                }
            }.padding(.vertical)
        }
    }
}
