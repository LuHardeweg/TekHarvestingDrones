# ARK: Survival Evolved Mod Design Document  
## Drone Terminal & Harvesting Drone

## 1. Overview

This mod introduces an automated harvesting loop centered around a new structure (**Drone Terminal**) and a new craftable creature (**Harvesting Drone**).

The Drone Terminal acts as the operational hub:
- Crafts drones
- Powers drones
- Defines the drone harvesting area
- Receives harvested resources from drones

The Harvesting Drone is a humanoid Tek-style robot worker that autonomously gathers resources within terminal range and deposits them back into the terminal inventory.

---

## 2. Core Features

### 2.1 New Structure: Drone Terminal

#### Purpose
A specialized structure that manages drone production, power, area restrictions, and resource intake.

#### Functional Requirements
- **Drone Crafting Station**
  - Players can craft Harvesting Drones at the terminal.
- **Drone Power Source**
  - Terminal provides power required for drone operation.
- **Harvest Radius Controller**
  - Drones assigned to this terminal can only harvest within a defined radius around it.
- **Resource Deposit Target**
  - Drones deposit harvested resources into the terminal inventory.

#### Design Notes
- Terminal should have a clear powered/unpowered state.
- Terminal UI should expose:
  - Craft Drone action
  - Radius value (or preset range tiers)
  - Linked/active drone count
  - Drone status summary (optional, future)

---

### 2.2 New Craftable Creature: Harvesting Drone

#### Purpose
Autonomous gatherer creature that harvests nearby resource nodes and returns resources to its terminal.

#### Visual/Animation Requirements
- Uses a humanoid “full Tek suit robot” appearance.
- Built from modular Tek armor meshes on the human skeleton.
- Reuses existing animations (skeleton remains unchanged).

#### Functional Requirements
- **Autonomous Harvesting**
  - Automatically seeks and harvests:
    - Rocks
    - Trees
    - Crystals
    - Gems
    - Bushes
- **Terminal-Bound Operation**
  - Only harvests inside the linked terminal’s active range.
- **Auto-Deposit**
  - Returns or transfers harvested resources to linked terminal inventory.
- **Tool Equipment System**
  - Can be equipped with:
    - Mining Laser
    - Chainsaw
  - Equipped tool increases relevant harvest yields.

---

## 3. Gameplay Loop

1. Player crafts and places a **Drone Terminal**.
2. Player crafts one or more **Harvesting Drones** at the terminal.
3. Terminal powers active drones.
4. Drones patrol/search within terminal radius.
5. Drones harvest valid resource nodes automatically.
6. Drones deposit resources in terminal.
7. Player collects resources from terminal inventory.

---

## 4. Systems Breakdown

## 4.1 Terminal System
- Structure placement and persistence
- Power state management
- Crafting inventory/recipes for drone creation
- Radius definition and overlap checks
- Resource inventory storage for drone deposits

## 4.2 Drone AI System
- Terminal linking/ownership
- Behavior states:
  - Idle
  - Search Resource
  - Move to Resource
  - Harvest/Attack
  - Return/Deposit
- Target filtering by allowed resource classes
- Range validation against terminal radius
- Failsafes if terminal is unpowered/destroyed/out of range

## 4.3 Harvest & Yield System
- Base yield table per resource type
- Tool modifier hooks:
  - Mining Laser modifier profile
  - Chainsaw modifier profile
- Optional durability/energy costs (future)

## 4.4 Equipment System
- Equip slot(s) on drone for harvesting tool
- Tool detection in harvest logic
- Yield multiplier application by tool type and resource class

---

## 5. Asset & Blueprint Plan (Initial)

### 5.1 Blueprints
- `BP_DroneTerminal` (structure)
- `BP_HarvestingDrone_Character` (creature/character)
- `ABP_HarvestingDrone` (animation blueprint; inherited/overridden)
- `BP_DroneAIController` (autonomous behavior)
- `BP_DroneTool_MiningLaser` (equipment item)
- `BP_DroneTool_Chainsaw` (equipment item)

### 5.2 Data Assets / Config (recommended)
- `DA_DroneHarvestTargets` (allowed node classes)
- `DA_DroneYieldModifiers` (tool × resource multipliers)
- `DA_DroneTerminalSettings` (default radius, power drain, limits)

### 5.3 Mesh/Animation
- Modular Tek armor skeletal meshes assembled on human skeleton
- Static mesh helmet attached via existing Tek helmet socket
- Existing animation set reused via inherited AnimBP override

---

## 6. Milestones

## Milestone 1 — Foundation
- [ ] Create Drone Terminal structure BP
- [ ] Implement terminal crafting entry for Harvesting Drone
- [ ] Spawn and link drone to terminal

## Milestone 2 — Visual & Animation Integration
- [ ] Assemble drone modular Tek body
- [ ] Attach static helmet to helmet socket
- [ ] Verify inherited animations (idle/walk/fall basic set)

## Milestone 3 — Autonomous Harvesting (MVP)
- [ ] Implement target search in radius
- [ ] Implement harvesting attack cycle for allowed node types
- [ ] Implement resource transfer to terminal

## Milestone 4 — Tool-Based Yield Bonuses
- [ ] Add tool equip support
- [ ] Add Mining Laser yield modifiers
- [ ] Add Chainsaw yield modifiers
- [ ] Validate balancing by resource type

## Milestone 5 — Polish & Stability
- [ ] Terminal power on/off behavior
- [ ] Drone fail states and recovery logic
- [ ] Multiplayer replication validation
- [ ] Performance pass (target scan intervals, AI tick cost)

---

## 7. MVP Scope (Current)

Included:
- Drone Terminal (crafting, power, range, deposit)
- Harvesting Drone (autonomous harvesting in range)
- Tool-based increased yields (Mining Laser, Chainsaw)

Deferred (Future):
- Advanced drone commands/UI
- Multiple drone roles
- Upgrade tree/perks
- Visual FX/audio polish
- Energy/fuel economy expansion

---

## 8. Risks & Technical Considerations

- **AI performance**: frequent node scanning can be expensive; use timed scans and filtering.
- **Replication**: drone AI and deposits must behave correctly on dedicated servers.
- **Balance**: automation can trivialize resource farming; tune speed, yield, and power costs.
- **Animation compatibility**: keep skeleton unchanged to preserve inherited animation behavior.
- **Terminal dependency**: define clear behavior when terminal is destroyed/unpowered.

---

## 9. Next Implementation Tasks

1. Build `BP_DroneTerminal` with inventory + craft entry for drone.
2. Build `BP_HarvestingDrone_Character` and terminal linking logic.
3. Implement basic AI state machine (Search → Harvest → Deposit).
4. Add radius restriction checks before selecting targets.
5. Add first-pass yield modifiers for Mining Laser and Chainsaw.
6. Run in-game test pass for:
   - Harvest correctness by node type
   - Deposit flow
   - Range compliance
   - Multiplayer behavior

---

## 10. Changelog

### v0.1 (Design Draft)
- Initial design for Drone Terminal and Harvesting Drone systems
- Defined MVP features, system breakdown, and milestone plan