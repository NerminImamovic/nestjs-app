output "repo_url" {
    value = aws_ecr_repository.repo.repository_url
}

output "repo_name" {
    value = aws_ecr_repository.repo.name
}
