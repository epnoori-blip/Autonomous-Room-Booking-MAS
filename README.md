# 🏢 Autonomous Room Booking System (JaCaMo)

An intelligent Multi-Agent System (MAS) built using the **BDI (Belief-Desire-Intention)** architecture with JaCaMo.  
The system demonstrates autonomous resource allocation in a university environment.

---

## 🚀 Scenario: Autonomous Room Booking

- **User Agent** requests a room with:
  - Capacity: 60 people
  - Equipment: projector

- **Room Agents** independently evaluate:
  - capacity
  - equipment
  - availability

- **Scheduler Agent** coordinates the matching process and selects the best candidate.

---

## ⚙️ Key Features

- 🧠 BDI-based autonomous reasoning
- 🏢 Decentralized decision-making
- 🔄 Dynamic state updates (availability → occupied)
- 📡 Agent communication via JaCaMo infrastructure
- 👁️ Compatible with JaCaMo Mind Inspector

---

## 🛠️ How to Run

```bash
gradle runMas --no-configuration-cache
