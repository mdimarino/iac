### POLÍTICAS ###
resource "aws_iam_policy" "iam_policy_read_only" {
  name        = "${var.application}-leitura-somente"
  path        = "/"
  description = "Politica de somente leitura no bucket"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${var.application}",
                "arn:aws:s3:::${var.application}/*"
            ]
        }
    ]
}
EOF

}

resource "aws_iam_policy" "iam_policy_read_write" {
  name        = "${var.application}-leitura-escrita"
  path        = "/"
  description = "Politica de leitura e escrita no bucket"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.application}",
                "arn:aws:s3:::${var.application}/*"
            ]
        }
    ]
}
EOF

}

### FUNÇÔES (ROLES) ###
resource "aws_iam_role" "iam_role_read_only" {
  name = "${var.application}-leitura-somente"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_role" "iam_role_read_write" {
  name = "${var.application}-leitura-escrita"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "iam_role_policy_read_only_attachment" {
  role       = aws_iam_role.iam_role_read_only.name
  policy_arn = aws_iam_policy.iam_policy_read_only.arn
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_read_write_attachment" {
  role       = aws_iam_role.iam_role_read_write.name
  policy_arn = aws_iam_policy.iam_policy_read_write.arn
}

