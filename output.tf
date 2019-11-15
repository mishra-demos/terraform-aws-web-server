output "elb_address" {
  value = "${aws_elb.web.dns_name}"
}

output "elb_zone_id" {
  value = "${aws_elb.web.zone_id}"
}

output "web_server_ips" {
    value = "${aws_instance.web.*.public_ip}"
}