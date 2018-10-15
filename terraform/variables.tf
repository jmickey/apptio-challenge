variable "region" {
  default = "ap-southeast-2"
}

variable "managed_by" {
  default     = "terraform"
  description = "terraform"
}

variable "app_name" {
  default     = "guestbook"
  description = "Name of the application"
}

variable "environment" {
  default     = "dev"
  description = "Name of the environment. e.g. prod, qa, dev"
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use"
  default     = 2
}

variable "repository_name" {
  default     = "apptio-web"
  description = "Name for Docker repo"
}

variable "elasticache_cache_name" {
  default = "guestbook-dev-redis"
  description = "Cluster name for Elasticache cluster"
}

variable "elasticache_instance_type" {
  default = "cache.t2.micro"
  description = "https://aws.amazon.com/elasticache/features/#Available_Cache_Node_Types"
}


