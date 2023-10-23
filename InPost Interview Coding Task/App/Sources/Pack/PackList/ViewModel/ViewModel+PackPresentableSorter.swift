extension PackListViewModel {
    struct PackPresentableSorter {
        func sortPacks(_ packs: [PackPresentable]) -> [PackPresentable] {
            /*
             1. Sort by 'sortOrderNumber' in descending order.
             2. Sort by 'pickupDate' in ascending order, considering the earliest date.
             3. Sort by 'expiryDate' in descending order, considering the latest date.
             4. Sort by 'storedDate' in descending order, considering the latest date.
             5. Sort by 'id' in ascending order.
             6. If a value is nil for any of the fields (pickupDate, expiryDate, storedDate), it will be placed at the end of the current sorting order.
             */

            packs.sorted { item1, item2 -> Bool in
                if item1.sortOrderNumber != item2.sortOrderNumber {
                    return item1.sortOrderNumber > item2.sortOrderNumber
                }

                if let pickupDate1 = item1.pickupDate, let pickupDate2 = item2.pickupDate {
                    if pickupDate1 != pickupDate2 {
                        return pickupDate1 > pickupDate2
                    }
                } else if item1.pickupDate != nil {
                    return true
                } else if item2.pickupDate != nil {
                    return false
                }

                if let expiryDate1 = item1.expiryDate, let expiryDate2 = item2.expiryDate {
                    if expiryDate1 != expiryDate2 {
                        return expiryDate1 < expiryDate2
                    }
                } else if item1.expiryDate != nil {
                    return true
                } else if item2.expiryDate != nil {
                    return false
                }

                if let storedDate1 = item1.storedDate, let storedDate2 = item2.storedDate {
                    if storedDate1 != storedDate2 {
                        return storedDate1 < storedDate2
                    }
                } else if item1.storedDate != nil {
                    return true
                } else if item2.storedDate != nil {
                    return false
                }

                if let id1 = Int(item1.id.value), let id2 = Int(item2.id.value) {
                    return id1 < id2
                }

                return item1.id < item2.id
            }
        }
    }
}
