variable "repo_name" {
    type = string
}

variable "keep_last_images" {
    type    = number
    default = 50
}

variable "def_tags" {
    type    = map
    default = {}
}
