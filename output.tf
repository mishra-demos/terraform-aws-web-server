output "elb_address" {
  value = "${aws_elb.web.dns_name}"
}

output "web_server_ips" {
    value = "${aws_instance.web.*.public_ip}"
}