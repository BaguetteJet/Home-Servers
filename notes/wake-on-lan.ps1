$mac = "AA:BB:CC:DD:EE:FF" -replace "[:-]"
$bytes = for ($i=0; $i -lt 12; $i+=2) { [Convert]::ToByte($mac.Substring($i,2),16) }
$packet = [byte[]](,0xFF * 6 + ($bytes * 16))
$udp = New-Object System.Net.Sockets.UdpClient
$udp.Connect("192.168.1.255",9)
$udp.Send($packet,$packet.Length)
$udp.Close()