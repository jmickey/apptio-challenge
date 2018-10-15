resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.elasticache_cache_name}"
  engine               = "redis"
  node_type            = "${var.elasticache_instance_type}"
  num_cache_nodes      = "1"
  parameter_group_name = "default.redis4.0"
  port                 = "6379"
  subnet_group_name    = "${aws_elasticache_subnet_group.redis_subnets.name}"
  security_group_ids   = ["${aws_security_group.elasticache.id}"]

  tags {
    name        = "${var.app_name}-${var.environment}-redis"
    environment = "${var.environment}"
    managed_by  = "${var.managed_by}"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnets" {
  name        = "${var.elasticache_cache_name}-elasticache-subnet-group"
  description = "Private subnets for the ElastiCache instances"

  subnet_ids = [
    "${aws_subnet.private.*.id}",
  ]
}

resource "aws_security_group" "elasticache" {
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags {
    Name        = "${var.app_name}-${var.environment}-elasticache-sg"
    Environment = "${var.environment}"
    ManagedBy   = "${var.managed_by}"
  }
}
