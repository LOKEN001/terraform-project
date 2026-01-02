variable "env" {
  description = "This is environment veriable for inftrasture"
  type        = string
}

variable "bucket_name" {
  description = "This is bucket name for inftrasture"
  type        = string
}

variable "hash-key" {
  description = "This is hash-key name for DynamoDB"
  type        = string
}

variable "instance_type" {
  description = "This is instance type"
  type        = string
}

variable "instance_count" {
  description = "This is instance count "
  type        = number
}
