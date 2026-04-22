output "jenkins_public_ip" {
  value       = aws_instance.jenkins.public_ip
  description = "Public IP of Jenkins EC2"
}

output "jenkins_public_dns" {
  value       = aws_instance.jenkins.public_dns
  description = "Public DNS of Jenkins EC2"
}

output "jenkins_url" {
  value       = "http://${aws_instance.jenkins.public_dns}:8080"
  description = "Jenkins URL"
}

output "instance_id" {
  value       = aws_instance.jenkins.id
  description = "EC2 instance ID"
}

output "instance_profile_name" {
  value       = aws_iam_instance_profile.jenkins.name
  description = "Instance profile name"
}
