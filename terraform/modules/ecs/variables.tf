variable "cluster_name" {}
variable "execution_role_arn" {}
variable "subnets" {
  type = list(string)
}
variable "security_group_id" {}
variable "lb_target_group_arn" {}
