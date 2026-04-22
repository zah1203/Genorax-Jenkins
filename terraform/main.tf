terraform {
          "iam:PassRole"
        ],
        Resource = var.passrole_arns
      },
      {
        Sid    = "CloudWatchLogsAndMetrics",
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricData",
          "cloudwatch:ListMetrics"
        ],
        Resource = "*"
      },
      {
        Sid    = "EC2DescribeForPipelines",
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeVpcs",
          "ec2:DescribeRouteTables",
          "ec2:DescribeImages"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_key_pair" "this" {
  count      = var.public_key_path != "" ? 1 : 0
  key_name   = "${local.name_prefix}-key"
  public_key = file(var.public_key_path)

  tags = local.tags
}

resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  iam_instance_profile        = aws_iam_instance_profile.jenkins.name
  associate_public_ip_address = true
  key_name                    = var.public_key_path != "" ? aws_key_pair.this[0].key_name : null

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }

  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    aws_region         = var.aws_region
    terraform_version  = var.terraform_version
    jenkins_admin_user = var.jenkins_admin_user
  })

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = local.tags
}
