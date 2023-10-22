import DomainKit
import Foundation

public struct PackDTO: Decodable {
    public enum Status: String, Codable {
        case created = "CREATED"
        case notReady = "NOT_READY"
        case confirmed = "CONFIRMED"
        case adoptedAtSourceBranch = "ADOPTED_AT_SOURCE_BRANCH"
        case sentFromSourceBranch = "SENT_FROM_SOURCE_BRANCH"
        case adoptedAtSortingCenter = "ADOPTED_AT_SORTING_CENTER"
        case sentFromSortingCenter = "SENT_FROM_SORTING_CENTER"
        case other = "OTHER"
        case delivered = "DELIVERED"
        case returnedToSender = "RETURNED_TO_SENDER"
        case avizo = "AVIZO"
        case outForDelivery = "OUT_FOR_DELIVERY"
        case readyToPickup = "READY_TO_PICKUP"
        case pickupTimeExpired = "PICKUP_TIME_EXPIRED"
    }

    public enum ShipmentType: String, Codable {
        case courier = "COURIER"
        case parcelLocker = "PARCEL_LOCKER"
    }

    public let id: String
    public let status: Supportable<Status>
    public let sender: String
    public let expiryDate: Date?
    public let pickupDate: Date?
    public let storedDate: Date?
    public let shipmentType: Supportable<ShipmentType>
}
