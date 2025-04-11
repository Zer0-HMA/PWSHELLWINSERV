Remove-Item -Path "C:\Temp\*.tmo" -Force -ErrorAction SilentlyContinue
New-NetFirewallRule -DisplayName "RegladePrueba" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8080
Remove-NetFirewallRule -DisplayName "RegladePrueba"
Add-DhcpServerv4Scope -Name "RedInterna" -StartRange 192.168.100.10 -EndRange 192.168.100.100 -SubnetMask 255.255.255.0
Set-DhcpServerv4OptionValue -ScopeId 192.168.100.0 -Router 192.168.100.1
Set-DhcpServerv4OptionValue -ScopeId 192.168.100.0 -DnsServer 8.8.8.8
Set-DhcpServerv4Scope -ScopeId 192.168.100.0 -State Active
Add-DnsServerPrimaryZone -Name "empresacapibara.local" -ZoneFile "empresacapibara.local.dns" -DynamicUpdate Secure
Add-DnsServerPrimaryZone -NetworkId "192.168.1.0/24" -ZoneFile "1.168.192.in-addr.arpa.dns" -ZoneType ReverseLookup
Add-DnsServerResourceRecordA -Name "srv01" -ZoneName "empresacapibara.local" -IPv4Address "192.168.1.10"
Add-DnsServerResourceRecordCName -Name "webalias" -ZoneName "empresacapibara.local" -HostNameAlias "srweb.empresacapibara.local"
