data "aws_ecr_repository" "existing_repo" {
  name = var.repo_name
}

resource "aws_ecr_repository" "repo" {
    count = data.aws_ecr_repository.existing_repo.repository_url == "" ? 1 : 0
    name                 = var.repo_name
    image_tag_mutability = "MUTABLE"
    tags                 = merge(
        var.def_tags,
        {
            Name = var.repo_name
        }
    )
}

resource "aws_ecr_lifecycle_policy" "lcp" {
    repository = aws_ecr_repository.repo.name
    policy = jsonencode({
       rules = [{
           rulePriority = 4
           description  = "keep last ${var.keep_last_images} images"
           action       = {
               type = "expire"
           }
           selection     = {
               tagStatus   = "any"
               countType   = "imageCountMoreThan"
               countNumber = var.keep_last_images
           }
       }]
    })
}
