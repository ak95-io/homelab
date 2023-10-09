resource "aws_instance" "openvpn" {
  tags = {
    Env     = "dev"
    Purpose = "OPENVPN"
    SubEnv  = "main"
  }

  ami                         = local.current_openvpn_ami
  associate_public_ip_address = true
  availability_zone           = "eu-west-1b"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  disable_api_termination              = true
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.medium"
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  root_block_device {
    tags = {
      Env             = "dev"
      Purpose         = "OPENVPN"
      SubEnv          = "main"
      Weekly4Snapshot = "true"
    }

    delete_on_termination = true
    encrypted             = true
    kms_key_id            = "arn:aws:kms:eu-west-1:277963164707:key/ed715194-3edc-423e-8c9c-5290c8227522"
    volume_size           = 20
    volume_type           = "gp3"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.main_public_subnet.id
  tenancy                = "default"
  user_data              = <<-EOF
  #cloud-config
  repo_update: true
  ntp:
    enabled: true
    ntp_client: chrony
  user: gypser
  users:
    - name: gypser
      sudo: ALL=(ALL) NOPASSWD:ALL
      groups: root
      ssh_authorized_keys:
        - ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOTuH16h7y9dleTZmGdQjbmEXFkV7vU6pRQVEo6R4eVO1NJXuWtxK371rjk4LHcjR0muwufbQdxTrw3SUiUMMhg= tieto@aws
    - name: deployment
      sudo: ALL=(ALL) NOPASSWD:ALL
      groups: root
      ssh-authorized-keys:
        - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTOyT3Wdsj7aDNDLEAgIbjS95EOsYt9SlZkxOnMtrm1XqBz0OXAIei/VxJZTGY1HcHclrzkOfmSa19l79Iqjbbi5NyYNECYL+wFeSgao4WugNgEdRlE2khzQZaCJv6/RYAgbuAds0aut4W0zw52yw9+hWfBXPY5dZQf68WFx1NjreRgcSD4c7QsDVE4KG5gLUqVCLtThEe9nBexKJcrTr3znciAUq2dcn8yUY9GNz8yI1QaAtYU3FMO5GGYPq8M8Y4LLkePHKzg6xk7bjQ+Gy0InGimAlr6tBiNcomoiONIZlU06PyyMUNVZdh/97WS6d2RTxah+mp2C4U9aBpnmN3 kozlosew@WW301961
  EOF
  vpc_security_group_ids = ["sg-0745aa9b0106d9be8"]
}
