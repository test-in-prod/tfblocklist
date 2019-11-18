locals {
    spamhaus_drop   =   "${distinct(split(",", data.external.spamhaus-drop.result["List"]))}"
    spamhaus_edrop  =   "${distinct(split(",", data.external.spamhaus-edrop.result["List"]))}"
    dshield_top10   =   "${distinct(split(",", data.external.dshield-top10.result["List"]))}"
}

output "all" {
    value = "${distinct(concat(local.spamhaus_drop,local.spamhaus_edrop,local.dshield_top10))}"
}

output "spamhaus_drop" {
    value = "${local.spamhaus_drop}"
}

output "spamhaus_edrop" {
    value = "${local.spamhaus_edrop}"
}

output "dshield_top10" {
    value = "${local.dshield_top10}"
}