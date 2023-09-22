terraform {
  cloud {
    organization = "igortelmenko"

    workspaces {
      name = "hexlet-03-workspace"
    }
  }
}