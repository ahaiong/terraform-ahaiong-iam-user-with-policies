locals {
  user_name = element(concat(aws_iam_user.this.*.id, [var.name]), 0)
}

resource "aws_iam_user" "this" {
  count = var.create_user ? 1 : 0

  name  = var.name
}

################################
# IAM group policy attachements
################################

resource "aws_iam_user_policy_attachment" "custom-arns" {
  count       = length(var.custom_user_policy_arns)

  user        = local.user_name
  policy_arn  = element(var.custom_user_policy_arns, count.index)
}

resource "aws_iam_user_policy_attachment" "custom" {
  count       = length(var.custom_user_policies)

  user        = local.user_name
  policy_arn  = element(aws_iam_policy.custom.*.arn, count.index)
}

###############
# IAM policies
###############
resource "aws_iam_policy" "custom" {
  count = length(var.custom_user_policies)

  name        = var.custom_user_policies[count.index]["name"]
  policy      = var.custom_user_policies[count.index]["policy"]
  description = lookup(var.custom_user_policies[count.index], "description", null)
}
