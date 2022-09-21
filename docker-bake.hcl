# DO NOT EDIT THIS FILE Make yours changes in /utils/docker-bake.blueprint.hcl

group "default" {
   targets = [
     
     "php81",
     "php80",
     "php74",
     "php73",
     "php72",
   ]
}

group "php81-apache-all" {
   targets = [
     "php81-slim-apache",
     "php81-apache",
     "php81-apache-node16","php81-apache-node14","php81-apache-node12","php81-apache-node10",
   ]
}
group "php81-fpm-all" {
   targets = [
     "php81-slim-fpm",
     "php81-fpm",
     "php81-fpm-node16","php81-fpm-node14","php81-fpm-node12","php81-fpm-node10",
   ]
}
group "php81-cli-all" {
   targets = [
     "php81-slim-cli",
     "php81-cli",
     "php81-cli-node16","php81-cli-node14","php81-cli-node12","php81-cli-node10",
   ]
}
group "php80-apache-all" {
   targets = [
     "php80-slim-apache",
     "php80-apache",
     "php80-apache-node16","php80-apache-node14","php80-apache-node12","php80-apache-node10",
   ]
}
group "php80-fpm-all" {
   targets = [
     "php80-slim-fpm",
     "php80-fpm",
     "php80-fpm-node16","php80-fpm-node14","php80-fpm-node12","php80-fpm-node10",
   ]
}
group "php80-cli-all" {
   targets = [
     "php80-slim-cli",
     "php80-cli",
     "php80-cli-node16","php80-cli-node14","php80-cli-node12","php80-cli-node10",
   ]
}
group "php74-apache-all" {
   targets = [
     "php74-slim-apache",
     "php74-apache",
     "php74-apache-node16","php74-apache-node14","php74-apache-node12","php74-apache-node10",
   ]
}
group "php74-fpm-all" {
   targets = [
     "php74-slim-fpm",
     "php74-fpm",
     "php74-fpm-node16","php74-fpm-node14","php74-fpm-node12","php74-fpm-node10",
   ]
}
group "php74-cli-all" {
   targets = [
     "php74-slim-cli",
     "php74-cli",
     "php74-cli-node16","php74-cli-node14","php74-cli-node12","php74-cli-node10",
   ]
}
group "php73-apache-all" {
   targets = [
     "php73-slim-apache",
     "php73-apache",
     "php73-apache-node16","php73-apache-node14","php73-apache-node12","php73-apache-node10",
   ]
}
group "php73-fpm-all" {
   targets = [
     "php73-slim-fpm",
     "php73-fpm",
     "php73-fpm-node16","php73-fpm-node14","php73-fpm-node12","php73-fpm-node10",
   ]
}
group "php73-cli-all" {
   targets = [
     "php73-slim-cli",
     "php73-cli",
     "php73-cli-node16","php73-cli-node14","php73-cli-node12","php73-cli-node10",
   ]
}
group "php72-apache-all" {
   targets = [
     "php72-slim-apache",
     "php72-apache",
     "php72-apache-node16","php72-apache-node14","php72-apache-node12","php72-apache-node10",
   ]
}
group "php72-fpm-all" {
   targets = [
     "php72-slim-fpm",
     "php72-fpm",
     "php72-fpm-node16","php72-fpm-node14","php72-fpm-node12","php72-fpm-node10",
   ]
}
group "php72-cli-all" {
   targets = [
     "php72-slim-cli",
     "php72-cli",
     "php72-cli-node16","php72-cli-node14","php72-cli-node12","php72-cli-node10",
   ]
}


group "php81" {
   targets = ["php81-apache-all","php81-fpm-all","php81-cli-all",]
}
group "php80" {
   targets = ["php80-apache-all","php80-fpm-all","php80-cli-all",]
}
group "php74" {
   targets = ["php74-apache-all","php74-fpm-all","php74-cli-all",]
}
group "php73" {
   targets = ["php73-apache-all","php73-fpm-all","php73-cli-all",]
}
group "php72" {
   targets = ["php72-apache-all","php72-fpm-all","php72-cli-all",]
}

variable "REPO" {default = "thecodingmachine/php"}
variable "TAG_PREFIX" {default = ""}
variable "PHP_PATCH_MINOR" {default = ""}
variable "IS_RELEASE" {default = "0"}
variable "GLOBAL_VERSION" {default = "v4"}

function "tag" {
    params = [PHP_VERSION, VARIANT]
    result = [
      equal("1",IS_RELEASE) ? "${REPO}:${PHP_VERSION}-${GLOBAL_VERSION}-${VARIANT}" : "",
      equal("1",IS_RELEASE) ? (notequal("",PHP_PATCH_MINOR) ? "${REPO}:${PHP_PATCH_MINOR}-${GLOBAL_VERSION}-${VARIANT}": "") : "",
      "${REPO}:${TAG_PREFIX}${PHP_VERSION}-${GLOBAL_VERSION}-${VARIANT}",
    ]
}

target "default" {
  context = "."
  args = {
    GLOBAL_VERSION = "${GLOBAL_VERSION}"
  }
  #platforms = ["linux/amd64", "linux/arm64"]
  platforms = [BAKE_LOCAL_PLATFORM]
  pull = true
  output = ["type=docker"] # export in local docker
}


###########################
##    PHP 8.1
###########################
# thecodingmachine/php:8.1-v4-slim-apache
target "php81-slim-apache" {
  inherits = ["default"]
  tags = tag("8.1", "slim-apache")
  dockerfile = "Dockerfile.slim.apache"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "apache"
  }
}

# thecodingmachine/php:8.1-v4-apache
target "php81-apache" {
  inherits = ["default"]
  tags = tag("8.1", "apache")
  dockerfile = "Dockerfile.apache"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "apache"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php81-slim-apache"
  }
}

# thecodingmachine/php:8.1-v4-apache-node16
target "php81-apache-node16" {
  inherits = ["default"]
  tags = tag("8.1", "apache-node16")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "apache-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php81-apache"
  }
}

# thecodingmachine/php:8.1-v4-apache-node14
target "php81-apache-node14" {
  inherits = ["default"]
  tags = tag("8.1", "apache-node14")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "apache-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php81-apache"
  }
}

# thecodingmachine/php:8.1-v4-apache-node12
target "php81-apache-node12" {
  inherits = ["default"]
  tags = tag("8.1", "apache-node12")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "apache-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php81-apache"
  }
}

# thecodingmachine/php:8.1-v4-apache-node10
target "php81-apache-node10" {
  inherits = ["default"]
  tags = tag("8.1", "apache-node10")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "apache-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php81-apache"
  }
}

###########################
##    PHP 8.1
###########################
# thecodingmachine/php:8.1-v4-slim-fpm
target "php81-slim-fpm" {
  inherits = ["default"]
  tags = tag("8.1", "slim-fpm")
  dockerfile = "Dockerfile.slim.fpm"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "fpm"
  }
}

# thecodingmachine/php:8.1-v4-fpm
target "php81-fpm" {
  inherits = ["default"]
  tags = tag("8.1", "fpm")
  dockerfile = "Dockerfile.fpm"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "fpm"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php81-slim-fpm"
  }
}

# thecodingmachine/php:8.1-v4-fpm-node16
target "php81-fpm-node16" {
  inherits = ["default"]
  tags = tag("8.1", "fpm-node16")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "fpm-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php81-fpm"
  }
}

# thecodingmachine/php:8.1-v4-fpm-node14
target "php81-fpm-node14" {
  inherits = ["default"]
  tags = tag("8.1", "fpm-node14")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "fpm-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php81-fpm"
  }
}

# thecodingmachine/php:8.1-v4-fpm-node12
target "php81-fpm-node12" {
  inherits = ["default"]
  tags = tag("8.1", "fpm-node12")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "fpm-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php81-fpm"
  }
}

# thecodingmachine/php:8.1-v4-fpm-node10
target "php81-fpm-node10" {
  inherits = ["default"]
  tags = tag("8.1", "fpm-node10")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "fpm-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php81-fpm"
  }
}

###########################
##    PHP 8.1
###########################
# thecodingmachine/php:8.1-v4-slim-cli
target "php81-slim-cli" {
  inherits = ["default"]
  tags = tag("8.1", "slim-cli")
  dockerfile = "Dockerfile.slim.cli"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "cli"
  }
}

# thecodingmachine/php:8.1-v4-cli
target "php81-cli" {
  inherits = ["default"]
  tags = tag("8.1", "cli")
  dockerfile = "Dockerfile.cli"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "cli"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php81-slim-cli"
  }
}

# thecodingmachine/php:8.1-v4-cli-node16
target "php81-cli-node16" {
  inherits = ["default"]
  tags = tag("8.1", "cli-node16")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "cli-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php81-cli"
  }
}

# thecodingmachine/php:8.1-v4-cli-node14
target "php81-cli-node14" {
  inherits = ["default"]
  tags = tag("8.1", "cli-node14")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "cli-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php81-cli"
  }
}

# thecodingmachine/php:8.1-v4-cli-node12
target "php81-cli-node12" {
  inherits = ["default"]
  tags = tag("8.1", "cli-node12")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "cli-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php81-cli"
  }
}

# thecodingmachine/php:8.1-v4-cli-node10
target "php81-cli-node10" {
  inherits = ["default"]
  tags = tag("8.1", "cli-node10")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "8.1"
    VARIANT = "cli-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php81-cli"
  }
}

###########################
##    PHP 8.0
###########################
# thecodingmachine/php:8.0-v4-slim-apache
target "php80-slim-apache" {
  inherits = ["default"]
  tags = tag("8.0", "slim-apache")
  dockerfile = "Dockerfile.slim.apache"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "apache"
  }
}

# thecodingmachine/php:8.0-v4-apache
target "php80-apache" {
  inherits = ["default"]
  tags = tag("8.0", "apache")
  dockerfile = "Dockerfile.apache"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "apache"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php80-slim-apache"
  }
}

# thecodingmachine/php:8.0-v4-apache-node16
target "php80-apache-node16" {
  inherits = ["default"]
  tags = tag("8.0", "apache-node16")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "apache-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php80-apache"
  }
}

# thecodingmachine/php:8.0-v4-apache-node14
target "php80-apache-node14" {
  inherits = ["default"]
  tags = tag("8.0", "apache-node14")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "apache-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php80-apache"
  }
}

# thecodingmachine/php:8.0-v4-apache-node12
target "php80-apache-node12" {
  inherits = ["default"]
  tags = tag("8.0", "apache-node12")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "apache-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php80-apache"
  }
}

# thecodingmachine/php:8.0-v4-apache-node10
target "php80-apache-node10" {
  inherits = ["default"]
  tags = tag("8.0", "apache-node10")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "apache-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php80-apache"
  }
}

###########################
##    PHP 8.0
###########################
# thecodingmachine/php:8.0-v4-slim-fpm
target "php80-slim-fpm" {
  inherits = ["default"]
  tags = tag("8.0", "slim-fpm")
  dockerfile = "Dockerfile.slim.fpm"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "fpm"
  }
}

# thecodingmachine/php:8.0-v4-fpm
target "php80-fpm" {
  inherits = ["default"]
  tags = tag("8.0", "fpm")
  dockerfile = "Dockerfile.fpm"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "fpm"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php80-slim-fpm"
  }
}

# thecodingmachine/php:8.0-v4-fpm-node16
target "php80-fpm-node16" {
  inherits = ["default"]
  tags = tag("8.0", "fpm-node16")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "fpm-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php80-fpm"
  }
}

# thecodingmachine/php:8.0-v4-fpm-node14
target "php80-fpm-node14" {
  inherits = ["default"]
  tags = tag("8.0", "fpm-node14")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "fpm-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php80-fpm"
  }
}

# thecodingmachine/php:8.0-v4-fpm-node12
target "php80-fpm-node12" {
  inherits = ["default"]
  tags = tag("8.0", "fpm-node12")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "fpm-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php80-fpm"
  }
}

# thecodingmachine/php:8.0-v4-fpm-node10
target "php80-fpm-node10" {
  inherits = ["default"]
  tags = tag("8.0", "fpm-node10")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "fpm-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php80-fpm"
  }
}

###########################
##    PHP 8.0
###########################
# thecodingmachine/php:8.0-v4-slim-cli
target "php80-slim-cli" {
  inherits = ["default"]
  tags = tag("8.0", "slim-cli")
  dockerfile = "Dockerfile.slim.cli"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "cli"
  }
}

# thecodingmachine/php:8.0-v4-cli
target "php80-cli" {
  inherits = ["default"]
  tags = tag("8.0", "cli")
  dockerfile = "Dockerfile.cli"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "cli"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php80-slim-cli"
  }
}

# thecodingmachine/php:8.0-v4-cli-node16
target "php80-cli-node16" {
  inherits = ["default"]
  tags = tag("8.0", "cli-node16")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "cli-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php80-cli"
  }
}

# thecodingmachine/php:8.0-v4-cli-node14
target "php80-cli-node14" {
  inherits = ["default"]
  tags = tag("8.0", "cli-node14")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "cli-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php80-cli"
  }
}

# thecodingmachine/php:8.0-v4-cli-node12
target "php80-cli-node12" {
  inherits = ["default"]
  tags = tag("8.0", "cli-node12")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "cli-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php80-cli"
  }
}

# thecodingmachine/php:8.0-v4-cli-node10
target "php80-cli-node10" {
  inherits = ["default"]
  tags = tag("8.0", "cli-node10")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "8.0"
    VARIANT = "cli-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php80-cli"
  }
}

###########################
##    PHP 7.4
###########################
# thecodingmachine/php:7.4-v4-slim-apache
target "php74-slim-apache" {
  inherits = ["default"]
  tags = tag("7.4", "slim-apache")
  dockerfile = "Dockerfile.slim.apache"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "apache"
  }
}

# thecodingmachine/php:7.4-v4-apache
target "php74-apache" {
  inherits = ["default"]
  tags = tag("7.4", "apache")
  dockerfile = "Dockerfile.apache"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "apache"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php74-slim-apache"
  }
}

# thecodingmachine/php:7.4-v4-apache-node16
target "php74-apache-node16" {
  inherits = ["default"]
  tags = tag("7.4", "apache-node16")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "apache-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php74-apache"
  }
}

# thecodingmachine/php:7.4-v4-apache-node14
target "php74-apache-node14" {
  inherits = ["default"]
  tags = tag("7.4", "apache-node14")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "apache-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php74-apache"
  }
}

# thecodingmachine/php:7.4-v4-apache-node12
target "php74-apache-node12" {
  inherits = ["default"]
  tags = tag("7.4", "apache-node12")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "apache-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php74-apache"
  }
}

# thecodingmachine/php:7.4-v4-apache-node10
target "php74-apache-node10" {
  inherits = ["default"]
  tags = tag("7.4", "apache-node10")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "apache-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php74-apache"
  }
}

###########################
##    PHP 7.4
###########################
# thecodingmachine/php:7.4-v4-slim-fpm
target "php74-slim-fpm" {
  inherits = ["default"]
  tags = tag("7.4", "slim-fpm")
  dockerfile = "Dockerfile.slim.fpm"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "fpm"
  }
}

# thecodingmachine/php:7.4-v4-fpm
target "php74-fpm" {
  inherits = ["default"]
  tags = tag("7.4", "fpm")
  dockerfile = "Dockerfile.fpm"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "fpm"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php74-slim-fpm"
  }
}

# thecodingmachine/php:7.4-v4-fpm-node16
target "php74-fpm-node16" {
  inherits = ["default"]
  tags = tag("7.4", "fpm-node16")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "fpm-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php74-fpm"
  }
}

# thecodingmachine/php:7.4-v4-fpm-node14
target "php74-fpm-node14" {
  inherits = ["default"]
  tags = tag("7.4", "fpm-node14")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "fpm-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php74-fpm"
  }
}

# thecodingmachine/php:7.4-v4-fpm-node12
target "php74-fpm-node12" {
  inherits = ["default"]
  tags = tag("7.4", "fpm-node12")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "fpm-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php74-fpm"
  }
}

# thecodingmachine/php:7.4-v4-fpm-node10
target "php74-fpm-node10" {
  inherits = ["default"]
  tags = tag("7.4", "fpm-node10")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "fpm-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php74-fpm"
  }
}

###########################
##    PHP 7.4
###########################
# thecodingmachine/php:7.4-v4-slim-cli
target "php74-slim-cli" {
  inherits = ["default"]
  tags = tag("7.4", "slim-cli")
  dockerfile = "Dockerfile.slim.cli"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "cli"
  }
}

# thecodingmachine/php:7.4-v4-cli
target "php74-cli" {
  inherits = ["default"]
  tags = tag("7.4", "cli")
  dockerfile = "Dockerfile.cli"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "cli"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php74-slim-cli"
  }
}

# thecodingmachine/php:7.4-v4-cli-node16
target "php74-cli-node16" {
  inherits = ["default"]
  tags = tag("7.4", "cli-node16")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "cli-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php74-cli"
  }
}

# thecodingmachine/php:7.4-v4-cli-node14
target "php74-cli-node14" {
  inherits = ["default"]
  tags = tag("7.4", "cli-node14")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "cli-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php74-cli"
  }
}

# thecodingmachine/php:7.4-v4-cli-node12
target "php74-cli-node12" {
  inherits = ["default"]
  tags = tag("7.4", "cli-node12")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "cli-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php74-cli"
  }
}

# thecodingmachine/php:7.4-v4-cli-node10
target "php74-cli-node10" {
  inherits = ["default"]
  tags = tag("7.4", "cli-node10")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.4"
    VARIANT = "cli-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php74-cli"
  }
}

###########################
##    PHP 7.3
###########################
# thecodingmachine/php:7.3-v4-slim-apache
target "php73-slim-apache" {
  inherits = ["default"]
  tags = tag("7.3", "slim-apache")
  dockerfile = "Dockerfile.slim.apache"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "apache"
  }
}

# thecodingmachine/php:7.3-v4-apache
target "php73-apache" {
  inherits = ["default"]
  tags = tag("7.3", "apache")
  dockerfile = "Dockerfile.apache"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "apache"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php73-slim-apache"
  }
}

# thecodingmachine/php:7.3-v4-apache-node16
target "php73-apache-node16" {
  inherits = ["default"]
  tags = tag("7.3", "apache-node16")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "apache-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php73-apache"
  }
}

# thecodingmachine/php:7.3-v4-apache-node14
target "php73-apache-node14" {
  inherits = ["default"]
  tags = tag("7.3", "apache-node14")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "apache-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php73-apache"
  }
}

# thecodingmachine/php:7.3-v4-apache-node12
target "php73-apache-node12" {
  inherits = ["default"]
  tags = tag("7.3", "apache-node12")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "apache-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php73-apache"
  }
}

# thecodingmachine/php:7.3-v4-apache-node10
target "php73-apache-node10" {
  inherits = ["default"]
  tags = tag("7.3", "apache-node10")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "apache-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php73-apache"
  }
}

###########################
##    PHP 7.3
###########################
# thecodingmachine/php:7.3-v4-slim-fpm
target "php73-slim-fpm" {
  inherits = ["default"]
  tags = tag("7.3", "slim-fpm")
  dockerfile = "Dockerfile.slim.fpm"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "fpm"
  }
}

# thecodingmachine/php:7.3-v4-fpm
target "php73-fpm" {
  inherits = ["default"]
  tags = tag("7.3", "fpm")
  dockerfile = "Dockerfile.fpm"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "fpm"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php73-slim-fpm"
  }
}

# thecodingmachine/php:7.3-v4-fpm-node16
target "php73-fpm-node16" {
  inherits = ["default"]
  tags = tag("7.3", "fpm-node16")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "fpm-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php73-fpm"
  }
}

# thecodingmachine/php:7.3-v4-fpm-node14
target "php73-fpm-node14" {
  inherits = ["default"]
  tags = tag("7.3", "fpm-node14")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "fpm-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php73-fpm"
  }
}

# thecodingmachine/php:7.3-v4-fpm-node12
target "php73-fpm-node12" {
  inherits = ["default"]
  tags = tag("7.3", "fpm-node12")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "fpm-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php73-fpm"
  }
}

# thecodingmachine/php:7.3-v4-fpm-node10
target "php73-fpm-node10" {
  inherits = ["default"]
  tags = tag("7.3", "fpm-node10")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "fpm-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php73-fpm"
  }
}

###########################
##    PHP 7.3
###########################
# thecodingmachine/php:7.3-v4-slim-cli
target "php73-slim-cli" {
  inherits = ["default"]
  tags = tag("7.3", "slim-cli")
  dockerfile = "Dockerfile.slim.cli"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "cli"
  }
}

# thecodingmachine/php:7.3-v4-cli
target "php73-cli" {
  inherits = ["default"]
  tags = tag("7.3", "cli")
  dockerfile = "Dockerfile.cli"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "cli"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php73-slim-cli"
  }
}

# thecodingmachine/php:7.3-v4-cli-node16
target "php73-cli-node16" {
  inherits = ["default"]
  tags = tag("7.3", "cli-node16")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "cli-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php73-cli"
  }
}

# thecodingmachine/php:7.3-v4-cli-node14
target "php73-cli-node14" {
  inherits = ["default"]
  tags = tag("7.3", "cli-node14")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "cli-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php73-cli"
  }
}

# thecodingmachine/php:7.3-v4-cli-node12
target "php73-cli-node12" {
  inherits = ["default"]
  tags = tag("7.3", "cli-node12")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "cli-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php73-cli"
  }
}

# thecodingmachine/php:7.3-v4-cli-node10
target "php73-cli-node10" {
  inherits = ["default"]
  tags = tag("7.3", "cli-node10")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.3"
    VARIANT = "cli-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php73-cli"
  }
}

###########################
##    PHP 7.2
###########################
# thecodingmachine/php:7.2-v4-slim-apache
target "php72-slim-apache" {
  inherits = ["default"]
  tags = tag("7.2", "slim-apache")
  dockerfile = "Dockerfile.slim.apache"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "apache"
  }
}

# thecodingmachine/php:7.2-v4-apache
target "php72-apache" {
  inherits = ["default"]
  tags = tag("7.2", "apache")
  dockerfile = "Dockerfile.apache"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "apache"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php72-slim-apache"
  }
}

# thecodingmachine/php:7.2-v4-apache-node16
target "php72-apache-node16" {
  inherits = ["default"]
  tags = tag("7.2", "apache-node16")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "apache-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php72-apache"
  }
}

# thecodingmachine/php:7.2-v4-apache-node14
target "php72-apache-node14" {
  inherits = ["default"]
  tags = tag("7.2", "apache-node14")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "apache-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php72-apache"
  }
}

# thecodingmachine/php:7.2-v4-apache-node12
target "php72-apache-node12" {
  inherits = ["default"]
  tags = tag("7.2", "apache-node12")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "apache-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php72-apache"
  }
}

# thecodingmachine/php:7.2-v4-apache-node10
target "php72-apache-node10" {
  inherits = ["default"]
  tags = tag("7.2", "apache-node10")
  dockerfile = "Dockerfile.apache.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "apache-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php72-apache"
  }
}

###########################
##    PHP 7.2
###########################
# thecodingmachine/php:7.2-v4-slim-fpm
target "php72-slim-fpm" {
  inherits = ["default"]
  tags = tag("7.2", "slim-fpm")
  dockerfile = "Dockerfile.slim.fpm"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "fpm"
  }
}

# thecodingmachine/php:7.2-v4-fpm
target "php72-fpm" {
  inherits = ["default"]
  tags = tag("7.2", "fpm")
  dockerfile = "Dockerfile.fpm"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "fpm"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php72-slim-fpm"
  }
}

# thecodingmachine/php:7.2-v4-fpm-node16
target "php72-fpm-node16" {
  inherits = ["default"]
  tags = tag("7.2", "fpm-node16")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "fpm-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php72-fpm"
  }
}

# thecodingmachine/php:7.2-v4-fpm-node14
target "php72-fpm-node14" {
  inherits = ["default"]
  tags = tag("7.2", "fpm-node14")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "fpm-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php72-fpm"
  }
}

# thecodingmachine/php:7.2-v4-fpm-node12
target "php72-fpm-node12" {
  inherits = ["default"]
  tags = tag("7.2", "fpm-node12")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "fpm-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php72-fpm"
  }
}

# thecodingmachine/php:7.2-v4-fpm-node10
target "php72-fpm-node10" {
  inherits = ["default"]
  tags = tag("7.2", "fpm-node10")
  dockerfile = "Dockerfile.fpm.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "fpm-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php72-fpm"
  }
}

###########################
##    PHP 7.2
###########################
# thecodingmachine/php:7.2-v4-slim-cli
target "php72-slim-cli" {
  inherits = ["default"]
  tags = tag("7.2", "slim-cli")
  dockerfile = "Dockerfile.slim.cli"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "cli"
  }
}

# thecodingmachine/php:7.2-v4-cli
target "php72-cli" {
  inherits = ["default"]
  tags = tag("7.2", "cli")
  dockerfile = "Dockerfile.cli"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "cli"
    FROM_IMAGE = "slim"
  }
  contexts = {
    slim = "target:php72-slim-cli"
  }
}

# thecodingmachine/php:7.2-v4-cli-node16
target "php72-cli-node16" {
  inherits = ["default"]
  tags = tag("7.2", "cli-node16")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "cli-node16"
    FROM_IMAGE = "fat"
    NODE_VERSION = "16"
  }
  contexts = {
    fat = "target:php72-cli"
  }
}

# thecodingmachine/php:7.2-v4-cli-node14
target "php72-cli-node14" {
  inherits = ["default"]
  tags = tag("7.2", "cli-node14")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "cli-node14"
    FROM_IMAGE = "fat"
    NODE_VERSION = "14"
  }
  contexts = {
    fat = "target:php72-cli"
  }
}

# thecodingmachine/php:7.2-v4-cli-node12
target "php72-cli-node12" {
  inherits = ["default"]
  tags = tag("7.2", "cli-node12")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "cli-node12"
    FROM_IMAGE = "fat"
    NODE_VERSION = "12"
  }
  contexts = {
    fat = "target:php72-cli"
  }
}

# thecodingmachine/php:7.2-v4-cli-node10
target "php72-cli-node10" {
  inherits = ["default"]
  tags = tag("7.2", "cli-node10")
  dockerfile = "Dockerfile.cli.node"
  args = {
    PHP_VERSION = "7.2"
    VARIANT = "cli-node10"
    FROM_IMAGE = "fat"
    NODE_VERSION = "10"
  }
  contexts = {
    fat = "target:php72-cli"
  }
}

