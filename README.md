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

HOME: ![Home](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=home.png)
RECORDS: ![Recors](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=records.png)
LAB AND DIAGNOSTIC: ![Lab and Diagnostic](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=Lab%20and-,Diagnostic.png)
LAB AND DIAGNOSTIC ERROR: ![Lab and Diagnostic Error (https://github.com/mithunkaruns10/DemoAppNSH/edit/master/README.md#:~:text=Lab%20and%20Diagnostic-,error,-retry.png)
RECORD DETAILS: ![Record details](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=Record-,details.png)

### Below iOS 26(iOS 17/18)

HOME: ![Home](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=Home.jpeg)
RECORDS: ![Recors](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=Records.jpeg)
LAB AND DIAGNOSTIC: ![Lab and Diagnostic](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=Lab%20and-,Diagnostic.jpeg)
LAB AND DIAGNOSTIC ERROR: ![Lab and Diagnostic Error (https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=Lab%20and%20Diagnostics-,loading.jpeg)
RECORD DETAILS: ![Record details](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=Record-,details.jpeg)


### Demo Video

A small demo of working of the App

[Watch the Demo](https://github.com/mithunkaruns10/DemoApp-NSH/edit/master/README.md#:~:text=recording.mov)


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

## Trade-offs
- **No repositor** - the view model talks to `FHIRFetching` directly. Extra indirection was not worth it for one endpoint.
- **Mapping is tested through the view model**, not with separate mapper tests. The success test still asserts mapped fields.
___
