variable "do_token" {
type = string
description = "Access token to digital ocean"
}

variable "my_ssh_key_name" {
  type = string
  description = "Public SSh key name"
}

variable "my_ssh_key_path" {
  type = string
  description = "Path to ssh key location"
}

variable "rebrain_ssh_key" {
  type = string
  description = "Rebrain public ssh key"
}
variable "parametrs" {
  type = object(
    {
      cpu_size = number
      ram_size = number
      disk_size = number
      image_type = string
      image_name = string
    }
  )
}

variable "devops_tag" {
 type = string
 descrdescription = "devops tag for each resources that can be mark" 
}

variable "email_tag" {
  type = string
  description = "user email for each resources that can be mark"
}
