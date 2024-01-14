# using the explicitly dependencies

resource "aws_iam_user" "admin1" {
  name       = "admin1"
  depends_on = [aws_route_table_association.terrform-public-rtb-1]

}

resource "aws_iam_user" "admin2" {
  name       = "admin2"
  depends_on = [aws_route_table_association.terrform-public-rtb-2]

}

resource "aws_iam_user" "admin3" {
  name       = "admin3"
  depends_on = [aws_route_table_association.terrform-public-rtb-3]

}
