resource "aws_iam_role" "observability_data_source" {
  name = "{var.prefix}DataSource"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = var.principal_identifiers
    }
  }
}

resource "aws_iam_role_policy_attachment" "observability_data_source" {
  role       = aws_iam_role.observability_data_source.name
  policy_arn = aws_iam_policy.observability_data_source.arn
}

resource "aws_iam_policy" "observability_data_source" {
  name   = "{var.prefix}DataSourcePolicy"
  policy = data.aws_iam_policy_document.observability_data_source.json
}

data "aws_iam_policy_document" "observability_data_source" {
  statement {
    sid    = "AllowReadingMetricsFromCloudWatch"
    effect = "Allow"
    actions = [
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:GetMetricData"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowReadingLogsFromCloudWatch"
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
      "logs:GetLogGroupFields",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:GetQueryResults",
      "logs:GetLogEvents"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowReadingTagsInstancesRegionsFromEC2"
    effect = "Allow"
    actions = [
      "ec2:DescribeTags",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowReadingResourcesForTags"
    effect = "Allow"
    actions = [
      "tag:GetResources"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowESGet"
    effect = "Allow"
    actions = [
      "es:ESHttpGet",
      "es:DescribeElasticsearchDomains",
      "es:ListDomainNames"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowESPost"
    effect = "Allow"
    actions = [
      "es:ESHttpPost"
    ]
    resources = [
      "arn:aws:es:*:*:domain/*/_msearch*",
      "arn:aws:es:*:*:domain/*/_opendistro/_ppl"
    ]
  }
  statement {
    sid    = "AllowAMPReadOnly"
    effect = "Allow"
    actions = [
      "aps:ListWorkspaces",
      "aps:DescribeWorkspace",
      "aps:QueryMetrics",
      "aps:GetLabels",
      "aps:GetSeries",
      "aps:GetMetricMetadata"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "athena:GetDatabase",
      "athena:GetDataCatalog",
      "athena:GetTableMetadata",
      "athena:ListDatabases",
      "athena:ListDataCatalogs",
      "athena:ListTableMetadata",
      "athena:ListWorkGroups"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "athena:GetQueryExecution",
      "athena:GetQueryResults",
      "athena:GetWorkGroup",
      "athena:StartQueryExecution",
      "athena:StopQueryExecution"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetPartition",
      "glue:GetPartitions",
      "glue:BatchGetPartition"
    ]
    resources = ["*"]
  }
}
