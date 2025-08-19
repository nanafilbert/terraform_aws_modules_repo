resource "aws_security_group" "alb" {
  name        = "${var.name}-alb-sg"
  description = "Security Group for ALB to allow HTTP and HTTPS traffic"
  vpc_id      = var.vpc_id

    ingress {
        from_port   = var.http_port
        to_port     = var.http_port
        protocol    = var.protocol
        cidr_blocks = var.outbound_cidr_blocks
    }

    ingress {
        from_port   = var.https_port
        to_port     = var.https_port
        protocol    = var.protocol
        cidr_blocks = var.outbound_cidr_blocks
    }
    egress {
        from_port   = var.outbound_port
        to_port     = var.outbound_port
        protocol    = var.protocol_2
        cidr_blocks = var.outbound_cidr_blocks
    }
     tags = merge(
    { Name = "${var.name}-alb_sg" },
    var.tags
  )
    
}

resource "aws_security_group" "app" {
    name        = "${var.name}-app-sg"
    description = "Security Group for Application to allow traffic from ALB"
    vpc_id      = var.vpc_id
    
    ingress {
        from_port   = var.http_port
        to_port     = var.http_port
        protocol    = var.protocol
        security_groups = [aws_security_group.alb.id]
        description = "Allow HTTP traffic from ALB"
    }

    ingress {
        from_port   = var.ssh_port
        to_port     = var.ssh_port
        protocol    = var.protocol
        cidr_blocks = [var.Admin_CIDR] 
        description = "Allow SSH From Admin CIDR"
    }
    
    
    egress {
        from_port   = var.outbound_port
        to_port     = var.outbound_port
        protocol    = var.protocol_2
        cidr_blocks = var.outbound_cidr_blocks
        description = "Allow all outbound traffic"
    }
     tags = merge(
    { Name = "${var.name}-app_sg" },
    var.tags
  )
  
}


resource "aws_security_group" "db" {
  name        = "${var.name}-db-sg"
  description = "Security Group for Database to allow traffic from Application"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = var.protocol
    security_groups = [aws_security_group.app.id]
    description = "Allow MySQL traffic from Application"
  }

  egress {
    from_port   = var.outbound_port
    to_port     = var.outbound_port
    protocol    = var.protocol_2
    cidr_blocks = var.outbound_cidr_blocks
    description = "Allow all outbound traffic"
    }

    tags = merge(
    { Name = "${var.name}-db_sg" },
    var.tags
  )
}

    



 
  