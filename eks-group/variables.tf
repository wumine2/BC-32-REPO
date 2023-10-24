variable "username" {
  type    = list(any)
  default = ["manager", "wunmi", "tinu"]
}

variable "env" {
  type    = list(any)
  default = ["Development", "Production"]
}

variable "tags" {
  type = map(string)
  default = {
    Env = "Production"
  }
}

