<img width="1426" height="400" alt="parkli" src="https://github.com/user-attachments/assets/116671f7-6ae4-4cd4-b130-03722e436348" />


[![Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?logo=flutter)](https://flutter.dev/)
[![Supabase](https://img.shields.io/badge/Backend-Supabase-3ECF8E?logo=supabase)](https://supabase.com/)
[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-4169E1?logo=postgresql)](https://www.postgresql.org/)
[![Dart](https://img.shields.io/badge/Language-Dart-0175C2?logo=dart)](https://dart.dev/)

---

## 📌 Project Preview


> **ParkLi** is a smart mobile application designed for real-time parking discovery and reservation[cite: 1]. It replaces high-cost hardware infrastructures (sensors and ALPR cameras) with a software-driven "User as a Sensor" model utilizing GPS geofencing and dynamic QR-code verification[cite: 1].

---

## 📖 Table of Contents
- [Overview](#-overview)
- [Key Features](#-key-features)
- [System Architecture & Workflow](#-system-architecture--workflow)
- [Tech Stack](#-tech-stack)
- [Pricing Models & Enforcement](#-pricing-models--enforcement)
- [Academic Context](#-academic-context)

---

## 📋 Overview
Finding parking spaces in high-density areas (universities, hospitals, downtown districts) often results in severe traffic congestion, wasted fuel, and driver frustration[cite: 1]. Traditional hardware-based solutions are expensive to deploy, maintain, and introduce continuous privacy concerns[cite: 1].

**ParkLi** addresses this by using mobile GPS capabilities and lightweight user interactions (GPS geofencing within a ~75m radius and dynamic QR code verification) for arrival and exit verification[cite: 1].

---

## ✨ Key Features

### 🚘 Driver Mobile App
* **Real-time Discovery & Interactive Maps:** Integrated interactive maps (`Flutter Map` with OpenStreetMap) for live availability and navigation via `Google Maps`[cite: 1].
* **Flexible Reservations:** Booking, session extensions, and dynamic cancellation rules[cite: 1].
* **Dual Check-In Verification:** Automated arrival validation using GPS geofencing or scanning entry/exit QR codes[cite: 1].
* **Violation & Dispute Reporting:** Automated complaint submission for occupied spots with plate evidence, triggering instant refunds and violation warnings[cite: 1].
* **Invoicing & Saved Spots:** Digital PDF receipts generation and bookmarking favorite parking spots[cite: 1].

### 🛠️ Admin Web Dashboard
* **Zone & Spot Management:** Define geographical boundaries, spot capacities, and pricing models (Category A/B)[cite: 1].
* **Real-time Analytics:** Dashboard tracking occupancy rates, revenue metrics, active violations, and user complaints[cite: 1].
* **Dispute Handling System:** Comprehensive audit trail to review user evidence and resolve disputes within a 48-hour SLA[cite: 1].
* **Dynamic QR Management:** Generate and update entrance/exit QR code tokens for targeted pilot locations[cite: 1].

---

## 📐 System Architecture & Workflow

ParkLi relies on a modern serverless backend paired with a mobile client[cite: 1]:

1. **Authentication:** User authentication via **Supabase Auth** integrated with **Authentica OTP** for phone verification[cite: 1].
2. **Arrival Verification Formula:**
   $$\text{Arrival Validated} = (\text{Distance to Spot} \le 75\text{m}) \lor \text{Valid Entry QR Code}$$
[cite: 1]
3. **Automated Enforcement:** A 5-minute grace period automatically marks unverified bookings as a "no-show" and penalizes non-compliant reservations[cite: 1].

---

## 🛠️ Tech Stack

| Domain | Technology / Tools |
| :--- | :--- |
| **Mobile Frontend** | Flutter Framework (Dart)[cite: 1] |
| **Backend & Database** | Supabase (PostgreSQL, Realtime Engine, Storage)[cite: 1] |
| **Maps & Location** | Flutter Map, OpenStreetMap, Google Maps SDK[cite: 1] |
| **Authentication & SMS** | Supabase Auth, Authentica SMS API[cite: 1] |
| **UI/UX Design** | Figma[cite: 1] |

---

## 💰 Pricing Models & Enforcement

* **Category A (Flat Rate):** One-time fee for fixed long-stay areas[cite: 1].
* **Category B (Hourly Rate):** Time-based pricing structure with paid session extensions for dynamic turnover spots[cite: 1].

---

## 🎓 Academic Context

This project was engineered and developed as part of a Senior Graduation Project for the **Bachelor of Science in Computer Science** degree at **Qassim University**[cite: 1].

---

## 🚀 Getting Started
### Prerequisites
* Flutter SDK (v3.x or higher)
* Android Studio / Visual Studio Code
* Dart SDK

### Quick Setup
1. **Clone the repository:**
   ```bash
git clone https://github.com/asayl-ace/Smart-Parking-Project.git
```
