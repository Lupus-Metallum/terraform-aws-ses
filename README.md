# terraform-aws-ses
Used to create a fully compliant SES domain

``` terraform
module "ses" {
  source  = "Lupus-Metallum/ses/aws"
  version = "1.1.0"

  zone_id         = "000000000"
  create_root_txt = true
  mail_from_name  = "bounce"
  ttl             = 300
}
```