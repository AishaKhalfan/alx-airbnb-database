# Normalize Your Database Design

Objective: Apply normalization principles to ensure the database is in the third normal form (3NF).

**Instructions:**

- Review your schema and identify any potential redundancies or violations of normalization principles.

- Adjust your database design to achieve 3NF, if necessary.

- Provide an explanation of your normalization steps in a Markdown file.

# Database Normalization to 3NF

This document explains how the provided schema adheres to the principles of First, Second, and Third Normal Forms (1NF, 2NF, 3NF).

---

## ✅ First Normal Form (1NF)

**Rule**: Eliminate repeating groups and ensure each field contains only atomic values.

**Analysis**:
- All tables use atomic columns (e.g., `first_name`, `email`, `rating`).
- No repeating groups or arrays.
- Each row has a unique primary key.

✅ The schema satisfies 1NF.

---

## ✅ Second Normal Form (2NF)

**Rule**: All non-key attributes must be fully functionally dependent on the entire primary key.

**Analysis**:
- Each table has a single-attribute primary key (`user_id`, `property_id`, etc.)
- No partial dependencies on part of a composite key.

✅ The schema satisfies 2NF.

---

## ✅ Third Normal Form (3NF)

**Rule**: No transitive dependencies. Non-key attributes must not depend on other non-key attributes.

**Improvements & Justifications**:

1. **User Roles**:
   - The `users` table uses an enum for the `role` field.
   - ✅ This avoids duplication of roles like "host", "guest", "admin". Since `role` is atomic and from a controlled enum, it complies with 3NF.

2. **Booking Status**:
   - The `status` field in `bookings` is correctly separated as an enum.
   - ✅ Prevents redundancy and enforces controlled vocabulary.

3. **Payments**:
   - `payment_method` is separated into its own enum type.
   - ✅ This design avoids repeating payment method strings in multiple rows.

4. **Reviews**:
   - The `rating` field includes a constraint to restrict values between 1 and 5.
   - `property_id` and `user_id` reference other tables, ensuring normalization.

5. **Messages**:
   - Proper use of foreign keys for `sender_id` and `recipient_id`.
   - No transitive or derived attributes.

✅ So, using lookup tables instead of enums is the more strictly normalized (3NF-compliant) approach.


**Rule**: Eliminate transitive dependencies. Non-key attributes must not depend on other non-key attributes.

### ✅ Changes Made:
1. **Role extracted to a separate `roles` table**:
   - Previously, `role` was stored as a string in `users`, which violates 3NF because if the role name changed, it would require updates in many rows.
   - Introduced `roles` table with `role_id` as the foreign key in `users`.
   - This removes transitive dependency: `user_id → role_id → role_name`.

2. **Clean foreign key relationships**:
   - `host_id` in `properties` now references `users.user_id`.
   - `guest_id` in `bookings` references `users.user_id`.
   - `booking_id` in `reviews` references `bookings.booking_id`.

### ✅ Results:
- All transitive dependencies removed.
- Referential integrity enforced.
- The schema now meets 3NF.

The schema is now normalized up to Third Normal Form (3NF), ensuring data integrity, reduced redundancy, and easier maintenance.

✅ The schema satisfies 3NF.

✅ So, using lookup tables instead of enums is the more strictly normalized (3NF-compliant) approach.
For example:
Instead of this:

```dbml
role role [not null]  // enum
```
You would have:

```dbml
role_id int [not null, ref: > roles.role_id]
```
And define:

```dbml
Table roles {
  role_id int [primary key]
  role_name varchar [unique, not null] // e.g. guest, host, admin
}
```
This eliminates the transitive dependency:
```user_id → role → role_name```

💡 TL;DR
Approach	3NF Compliant?	Best For
Enums	✅ Basic 3NF	Simple, static value sets
Lookup Tables (normalized)	✅✅ Stronger 3NF	Dynamic, descriptive, or extendable values

---

## Summary

The database schema is well-structured and adheres to best practices for normalization up to the Third Normal Form (3NF). It avoids redundancy, enforces data integrity via foreign keys and enums, and maintains clean entity relationships.

"""
