locals {
  common_tags = { module = "app-gateway" }
  location    = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }

  frontend_ip_configuration_name      = "appGatewayFrontendIP"
  frontend_priv_ip_configuration_name = "appGatewayPrivFrontendIP"

  disabled_rule_group_settings_dev_portal = [
    {
      rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
      rules = [
        942100,
        942200,
        942110,
        942180,
        942260,
        942340,
        942370,
        942430,
        942440
      ]
    },
    {
      rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
      rules = [
        920300,
        920330
      ]
    },
    {
      rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
      rules = [
        931130
      ]
    }
  ]

  disabled_rule_group_settings = var.disable_waf_rules_for_dev_portal ? concat(local.disabled_rule_group_settings_dev_portal, try(var.waf_configuration.disabled_rule_group, [])) : try(var.waf_configuration.disabled_rule_group, [])
}