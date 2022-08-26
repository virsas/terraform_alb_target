# terraform_alb

Terraform module to create AWS loadbalancer targets to EC2 IPs

##  Dependencies

- VPC - <https://github.com/virsas/terraform_vpc>

## Files

- None

## Terraform example

``` terraform
##############
# Variable
##############
variable "alb_target_api" {
  default = {
    name = "api"
    port = 8080
    healthcheck = "/health"
  }
}

##############
# Module
##############
module "alb_tg_api" {
  source = "git::https://github.com/virsas/terraform_alb_target_ip.git?ref=v1.0.0"
  target = var.alb_target_api
  vpc_id  = module.vpc_main.id
  instances = [ module.ec2_ecs1.private_ip, module.ec2_ecs2.private_ip ]
}
```

## Outputs

- arn