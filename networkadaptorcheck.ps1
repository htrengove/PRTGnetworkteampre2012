﻿#Parameters, provided by PRTG parameters in the format '%device' '%adaptor'
param([string]$IPServer = "N/A",[string]$IPAdaptor = "N/A")
#Get Network Adaptor Stats
$workings = Get-WmiObject -Namespace "root\cimV2" -Class "Win32_PerfFormattedData_Tcpip_NetworkInterface" -ComputerName $IPServer | Select-Object Name,PacketsPersec,PacketsReceivedPersec,PacketsSentPersec,BytesReceivedPersec,BytesSentPersec,BytesTotalPersec,CurrentBandwidth | Where-Object {$_.Name -like $IPAdaptor}
#Calculations, Join Adaptors outputs
$PacketsPersec = ($workings.PacketsPersec | Measure-Object -sum).Sum
$PacketsReceivedPersec = ($workings.PacketsReceivedPersec | Measure-Object -sum).Sum
$PacketsSentPersec = ($workings.PacketsSentPersec | Measure-Object -sum).Sum
$BytesReceivedPersec = ($workings.BytesReceivedPersec | Measure-Object -sum).Sum
$BytesSentPersec = ($workings.BytesSentPersec | Measure-Object -sum).Sum
$BytesTotalPersec = ($workings.BytesTotalPersec | Measure-Object -sum).Sum
$CurrentBandwidth = ($workings.CurrentBandwidth | Measure-Object -sum).Sum
$CurrentBandwidthGB = $CurrentBandwidth / 1000000
#PRTG Output
"<prtg>"
       "<result>"
       "<channel>PacketsPerSec</channel>"
       "<value>$PacketsPersec</value>"
       "</result>"
       "<result>"
       "<channel>PacketsReceivedPersec</channel>"
       "<value>$PacketsReceivedPersec</value>"
       "</result>"
       "<channel>PacketsSentPersec</channel>"
       "<value>$PacketsSentPersec</value>"
       "</result>"
       "<channel>BytesReceivedPersec</channel>"
       "<value>$BytesReceivedPersec</value>"
       "</result>"
       "<channel>BytesSentPersec</channel>"
       "<value>$BytesSentPersec</value>"
       "</result>"
       "<channel>BytesTotalPersec</channel>"
       "<value>$BytesTotalPersec</value>"
       "</result>"
       "<channel>CurrentBandwidth</channel>"
       "<value>$CurrentBandwidthGB</value>"
       "</result>"
"</prtg>" 