variable "vpc_cidr" {
    description = "value for vpc cidr block"
    type = string
} 
variable "public_subnet_cidr" {
    description = "value for public subnet cidr block"
    type = string
} 
variable "private_subnet_cidr" {
    description = "value for private cidr block"
    type = string
} 
variable "availability_zone" {
    description = "value for Availability zone "
    type = string
}
variable "region" {
    description = "value for aws region"
    type = string
}