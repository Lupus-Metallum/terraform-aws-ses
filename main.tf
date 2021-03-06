data "aws_route53_zone" "this" {
  zone_id = var.zone_id
}

data "aws_region" "current" {}

resource "aws_ses_domain_identity" "this" {
  domain = data.aws_route53_zone.this.name
}

resource "aws_ses_domain_dkim" "this" {
  domain = data.aws_route53_zone.this.name
}

resource "aws_ses_domain_mail_from" "this" {
  domain           = aws_ses_domain_identity.this.domain
  mail_from_domain = "${var.mail_from_name}.${data.aws_route53_zone.this.name}"
}

resource "aws_route53_record" "this_amazonses_verification_record" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_amazonses.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = var.ttl
  records = [aws_ses_domain_identity.this.verification_token]
}

resource "aws_ses_domain_identity_verification" "this" {
  domain = aws_ses_domain_identity.this.id

  depends_on = [aws_route53_record.this_amazonses_verification_record]
}

resource "aws_route53_record" "this_mx" {
  count   = var.create_root_mx ? 1 : 0
  zone_id = data.aws_route53_zone.this.zone_id
  name    = data.aws_route53_zone.this.name
  type    = "MX"
  ttl     = var.ttl
  records = ["10 inbound-smtp.${data.aws_region.current.name}.amazonaws.com."]
}
resource "aws_route53_record" "this_autodiscover" {
  count   = var.create_root_autodiscover ? 1 : 0
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "autodiscover.${data.aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl
  records = ["autodiscover.mail.${data.aws_region.current.name}.awsapps.com."]
}

resource "aws_route53_record" "this_amazonses_dkim_record" {
  count   = 3
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = var.ttl
  records = ["${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "this_amazonses_txt" {
  count   = var.create_root_txt == true ? 1 : 0
  zone_id = data.aws_route53_zone.this.zone_id
  name    = data.aws_route53_zone.this.name
  type    = "TXT"
  ttl     = var.ttl
  records = ["v=spf1 include:amazonses.com ~all"]
}

resource "aws_route53_record" "this_amazonses_dmarc_txt" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_dmarc.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = var.ttl
  records = ["v=DMARC1;p=quarantine;pct=100;fo=1"]
}

resource "aws_route53_record" "this_ses_domain_mail_from_mx" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = aws_ses_domain_mail_from.this.mail_from_domain
  type    = "MX"
  ttl     = var.ttl
  records = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

resource "aws_route53_record" "this_ses_domain_mail_from_txt" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = aws_ses_domain_mail_from.this.mail_from_domain
  type    = "TXT"
  ttl     = var.ttl
  records = ["v=spf1 include:amazonses.com -all"]
}