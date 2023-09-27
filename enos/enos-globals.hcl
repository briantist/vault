# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

globals {
  backend_tag_key = "VaultStorage"
  build_tags = {
    "ce"               = ["ui"]
    "ent"              = ["ui", "enterprise", "ent"]
    "ent.fips1402"     = ["ui", "enterprise", "cgo", "hsm", "fips", "fips_140_2", "ent.fips1402"]
    "ent.hsm"          = ["ui", "enterprise", "cgo", "hsm", "venthsm"]
    "ent.hsm.fips1402" = ["ui", "enterprise", "cgo", "hsm", "fips", "fips_140_2", "ent.hsm.fips1402"]
  }
  distro_version = {
    "amazon_linux" = var.distro_version_amazon_linux
    "leap"         = var.distro_version_leap
    "rhel"         = var.distro_version_rhel
    "sles"         = var.distro_version_sles
    "ubuntu"       = var.distro_version_ubuntu
  }
  package_manager = {
    "amazon_linux" = "yum"
    "leap"         = "zypper"
    "rhel"         = "yum"
    "sles"         = "zypper"
    "ubuntu"       = "apt"
  }
  packages = ["jq"]
  distro_packages = {
    ubuntu = ["netcat"]
    rhel   = ["nc"]
  }
  sample_attributes = {
    aws_region = ["us-east-1", "us-west-2"]
  }
  tags = merge({
    "Project Name" : var.project_name
    "Project" : "Enos",
    "Environment" : "ci"
  }, var.tags)
  vault_install_dir_packages = {
    amazon_linux = "/bin"
    leap         = "/usr/bin"
    rhel         = "/bin"
    sles         = "/bin"
    ubuntu       = "/usr/bin"
  }
  vault_license_path = abspath(var.vault_license_path != null ? var.vault_license_path : joinpath(path.root, "./support/vault.hclic"))
  vault_tag_key      = "Type" // enos_vault_start expects Type as the tag key
}
