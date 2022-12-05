import ProjectDescription

let workspace = Workspace(
  name: "LifeBetter",
  projects: [
    "Targets/*",
    "Targets/Subway/*",
    "Targets/Platform/*",
    "Targets/Core/*",
//    "Targets/Core/Networking/*", // Networking Demo app
//    "Targets/Subway/Subway/*" // Subway Demo app
  ]
)
