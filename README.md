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
<!-- BEGIN_TF_DOCS -->

<img src="https://raw.githubusercontent.com/Lupus-Metallum/brand/master/images/logo.jpg" width="400"/>



## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.this_amazonses_dkim_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_amazonses_dmarc_txt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_amazonses_txt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_amazonses_verification_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_autodiscover](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_ses_domain_mail_from_mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_ses_domain_mail_from_txt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ses_domain_dkim.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_identity_verification.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification) | resource |
| [aws_ses_domain_mail_from.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_mail_from) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_mail_from_name"></a> [mail\_from\_name](#input\_mail\_from\_name) | The name we should use for the mail from parameter | `string` | n/a | yes |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | The name we should use for the mail from parameter | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The zone ID of the hosted zone | `string` | n/a | yes |
| <a name="input_create_root_autodiscover"></a> [create\_root\_autodiscover](#input\_create\_root\_autodiscover) | Should this module create the root autodiscover record for the zone? | `bool` | `false` | no |
| <a name="input_create_root_mx"></a> [create\_root\_mx](#input\_create\_root\_mx) | Should this module create the root MX record for the zone? | `bool` | `false` | no |
| <a name="input_create_root_txt"></a> [create\_root\_txt](#input\_create\_root\_txt) | Should this module create the root TXT record for the zone? | `bool` | `false` | no |
<!-- END_TF_DOCS -->