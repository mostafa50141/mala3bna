# Data Model: Player Payments Screen

## PaymentItem

The static data model object meant for representation. It handles structural typings for layout formatting.

| Field | Type | Description |
|-----------|----------|-------------|
| `id` | `String` | Unique transaction ID string |
| `courtName` | `String` | Name of the booked court |
| `courtImage` | `String` | Path to asset image of court |
| `date` | `String` | Formatted readable date |
| `time` | `String` | Timestamp string (e.g. 10:00 PM) |
| `amount` | `double` | EGP Currency amount |
| `status` | `String` | "Paid" or "Pending" identifier |
