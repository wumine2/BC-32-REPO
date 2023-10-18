output "oidc-url" {
    value = aws_iam_openid_connect_provider.eks.arn
}

output "oidc-arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

output "test_policy_arn" {
  value = aws_iam_role.test_oidc.arn
}