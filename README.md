# Terraform IP Blocklist #

This is a module that provides an IP blocklist for publicly-accessible internet resources.

It basically transforms the following [sources](https://docs.netgate.com/pfsense/en/latest/packages/pfblocker.html#available-lists) to something terraform can understand and consume in things like firewall rules.

- [Spamhaus-Drop](http://www.spamhaus.org/drop/drop.txt)
- [Spamhaus-EDrop](http://www.spamhaus.org/drop/edrop.txt)
- [DShield Top 10](https://feeds.dshield.org/top10-2.txt)

## Example Usage ##

```hcl
module "ipblocklist" {
    source  =   "github.com/test-in-prod/tfblocklist"
}

resource "azurerm_network_security_rule" "blocklist" {
    resource_group_name         =   "${azurerm_resource_group.main.name}"
    network_security_group_name =   "${azurerm_network_security_group.main.name}"

    name                        =   "blocklist"
    priority                    =   100
    direction                   =   "Inbound"
    access                      =   "Deny"
    protocol                    =   "*"
    source_address_prefixes     =   "${module.ipblocklist.all}"
    source_port_range           =   "*"
    destination_address_prefix  =   "*"
    destination_port_range      =   "*"
}
```

This will use the combined `all` list of IPs in CIDR notation to block traffic to your vnet in Azure.

## Caveats ##

- On Linux, you must install [powershell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux) and _may_ need to alias `powershell` to `/usr/bin/pwsh`