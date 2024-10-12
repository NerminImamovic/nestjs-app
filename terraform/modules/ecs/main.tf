resource "aws_ecs_cluster" "my_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "nestjs-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "nestjs-app"
      image     = "275221252783.dkr.ecr.us-east-1.amazonaws.com/nestjs-app:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "my_service" {
  name            = "nestjs-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "nestjs-app"
    container_port   = 3000
  }
}
