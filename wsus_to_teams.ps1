<#
Prüft WSUS auf neue, nicht genehmigte Updates und sendet bei Bedarf eine Nachricht an Teams.

@version: 1.0
@author: mmai 04.2020
#>

$uri = "$Webhook_url"

$num = (Get-WsusUpdate -Classification All -Approval Unapproved | Measure-Object).Count

$body = ConvertTo-JSON @{
    text = "Es sind $num neue, nicht genehmigte Updates verfuegbar."
}

if ($num -gt 0) {
    Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json'
}