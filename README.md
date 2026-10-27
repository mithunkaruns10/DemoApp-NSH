# DemoApp-NSH
A simple iOS application that displays two tabs Home and Report. The Report tab displays a Diagnostic Report (Laboratory report - Hematology) for a patient.

**Minimum iOS version:** 17.0
**Language:** Swift, SwiftUI
**Xcode version:** 26 or later (Xcode 26 is used for development, could not update it to 27 since low disc space in Mac)

The deployment target is **iOS 17** since `@Observable` framework requires it and Apple's FHIRModels package is integrated against that baseline.

***Liquid Glass** designs changes will be applied automatically if run in iOS 26 and above
---

## Screenshots

### iOS 26

***HOME:*** 
<img width="1206" height="2622" alt="home" src="https://github.com/user-attachments/assets/901bb677-ca7b-48c5-9fc2-0b7ae4ecc551" />
***RECORDS:*** 
<img width="1206" height="2622" alt="records" src="https://github.com/user-attachments/assets/1aa3ef86-35b2-4d52-b336-83de87f9ba5b" />
***LAB AND DIAGNOSTIC:***
<img width="1206" height="2622" alt="Lab and Diagnostic" src="https://github.com/user-attachments/assets/bbffe7c6-36cb-4071-a15f-0ae3d0b9221f" />
***LAB AND DIAGNOSTIC ERROR:*** 
<img width="1206" height="2622" alt="Lab and Diagnostic error retry" src="https://github.com/user-attachments/assets/2690470f-e1e4-4b14-846b-0afe20820e0b" />
***RECORD DETAILS:***
<img width="1206" height="2622" alt="Record details" src="https://github.com/user-attachments/assets/90e17354-e2d0-41c9-98b9-14051fb54c6b" />

### Below iOS 26(iOS 17/18)
***HOME:*** 
<img width="750" height="1334" alt="Home" src="https://github.com/user-attachments/assets/eaaf869c-b47d-4701-8f2a-0c07c43e00df" />
***RECORDS:*** 
<img width="750" height="1334" alt="Records" src="https://github.com/user-attachments/assets/d124cd24-1b30-4126-acfc-9df067f721c8" />
***LAB AND DIAGNOSTIC:***
<img width="750" height="1334" alt="Lab and Diagnostic" src="https://github.com/user-attachments/assets/ba35dd2a-00b7-4ab3-bc61-6b79cfd5c3dc" />
***LAB AND DIAGNOSTIC ERROR:*** 
<img width="750" height="1334" alt="Lab and Diagnostic error retry" src="https://github.com/user-attachments/assets/47cb18f8-d42c-4398-84ba-ce19930ac884" />
***LAB AND DIAGNOSTIC LOADING:***
<img width="750" height="1334" alt="Lab and Diagnostics loading" src="https://github.com/user-attachments/assets/1c566989-eee4-45ab-b042-ac78e35439f7" />
***RECORD DETAILS:***
<img width="750" height="1334" alt="Record details" src="https://github.com/user-attachments/assets/f5a5d244-96d0-401e-9d9b-2a4cacc730d0" />


### Demo Video

A small demo of working of the App can be found in ***screenshots/recording.MOV***

## Setup

1. Clone the repo and open the project
```bash
git clone https://github.com/mithunkaruns10/DemoApp-NSH.git
cd DemoApp-NSH
open DemoApp-NSH.xcodeproj
```
2. Select the **DemoApp-NSH** scheme and an iOS 17+ simulator
3. Let Xcode resolve Swift packages. The only package is **FHIRModels** (`ModelsR4` 0.9.3) from `https://github.com/apple/FHIRModels.git`.
4. Build and run (⌘R).
5. To run unit tests: **Product → Test** (⌘U)

No API keys, login, or extra config. The app loads `https://build.fhir.org/diagnosticreport-example.json` over HTTPS.
---

## Architecture

```
DemoApp-NSH/
├── App/                 Root, tabs, navigation routes
├── Core/                Shared UI state, date helpers
├── DesignSystem/        Color, font, icons, nav bar, back button
├── Features/
│   ├── Home/            Home tab
│   └── Records/         List + details (screens, view models, UI models, mapper)
├── Network/             Endpoint, client, FHIR parse, errors
DemoApp-NSHTests/        View-model and date tests + mocks
```
---

## Flow

1. `LabAndDiagnosticListScreen` starts `RecordsViewModel.load()` in `.task`.
2. `FHIRClient` GETs the FHIR example with `Accept: application/fhir+json`.
3. `Report.parse` decodes Apple `ModelsR4` (`ResourceProxy` → `Bundle` or `DiagnosticReport`, plus `Observation`s).
4. `LabReportMapper` maps those types into `LabReport` / `LabObservation`.
5. The view model exposes `AppUIState`: `loading` / `loaded` / `failed`.

---

## Usage of FHIRModel Package

The app uses Apple’s **FHIRModels** (`ModelsR4` 0.9.3), not a hand-rolled Codable FHIR graph.

`JSONDecoder.fhirModelsReadyDecoder()` - Decode FHIR JSON
`ResourceProxy` - Accept a Bundle or a standalone DiagnosticReport
`DiagnosticReport`, `Observation`, `CodeableConcept`, `Quantity`, `Reference` - Data types for mapping

## Design patterns

**MVVM** - Screens observe view models; views do not call `URLSession`
**Protocol-oriented dependency injection** - `FHIRFetching` + client injected in `RecordsViewModel.init`(make it testable)
**Mapper** - FHIR R4 → app models in `LabReportMapper`
**Feature modules** - `Features/Home`, `Features/Records`
**Coordinator-style routing** - `NavigationStack` + `AppRoute` / `AppTab`
**state** - `AppUIState` drives loading, list, and error UI


## Coding standards and best practices

- **Swift Concurrency** — `async`/`await` for loading;
- **Isolation** — view models are `@MainActor`. Network types, parse, mapper, and UI models are `nonisolated` / `Sendable` so they can cross `await`. That split is ready for Swift 6; the language mode is still Swift 5
- **Protocol injection** — `FHIRFetching` is the test seam. Production uses `FHIRClient`; tests use `MockReportFetching` in the test target.
- **Observation** — `@Observable` instead of `ObservableObject` / `@Published`.
- **Value UI state** — `AppUIState<Value>` for loading, success, and failure.
- **Design tokens** — `AppColor`, `AppFont`, `AppIcon` instead of scattered literals (not every shadow/grey is tokenized yet).
- **Swift Testing** — `#expect` in `DemoApp-NSHTests`, not XCTest for unit tests.

---

## Assumptions

- Assumed **minimum iOS version** as 17.
- Assumed and used the public FHIR example documentation for JSON parsing
- **Home** is just a screen with a `Demo App` text, no other UI components or state.
- UI is always **Light** (`UIUserInterfaceStyle = Light`).
- Language support is only English since API provide only English.
- Assumed and used Native **Navigation Bars, Bottom tab**
- Used free icons that matches the provided design(reference: https://www.flaticon.com/free-icon)
- Added a dummy **App Icon**

___

## iOS 26 vs below iOS 26

- There are some major UI difference from the two iOS versions and hence app installed in below iOS 26 version will have a flat Navigation bar without the right bottom rounded corner(It requires some workaround using UIKIt to achieve the similar appearance).
- Created a custom back button to override the native back button to match the reference design
___

## Unit tests
Target: **DemoApp-NSHTests** (Swift Testing). The mock client lives in the test target, not the app.
Run with ⌘U in Xcode.

---

## Git

Work lives on **`master`**. I am the only contributor, so there are no feature branches — each commit was made directly on `master` as the UI, network layer, mapping, and tests landed.

---

## Trade-offs
- **No repositor** - the view model talks to `FHIRFetching` directly. Extra indirection was not worth it for one endpoint.
- **Mapping is tested through the view model**, not with separate mapper tests. The success test still asserts mapped fields.
___
