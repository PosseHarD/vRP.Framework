netsh advfirewall firewall add rule name="80 TCP" dir=in action=allow protocol=TCP localport=80
cls
netsh advfirewall firewall add rule name="80 UDP" dir=in action=allow protocol=UDP localport=80
cls
netsh advfirewall firewall add rule name="80 TCP" dir=out action=allow protocol=TCP localport=80
cls
netsh advfirewall firewall add rule name="80 UDP" dir=out action=allow protocol=UDP localport=80
cls

netsh advfirewall firewall add rule name="8080 TCP" dir=in action=allow protocol=TCP localport=8080
cls
netsh advfirewall firewall add rule name="8080 UDP" dir=in action=allow protocol=UDP localport=8080
cls
netsh advfirewall firewall add rule name="8080 TCP" dir=out action=allow protocol=TCP localport=8080
cls
netsh advfirewall firewall add rule name="8080 UDP" dir=out action=allow protocol=UDP localport=8080
cls


netsh advfirewall firewall add rule name="443 TCP" dir=in action=allow protocol=TCP localport=443
cls
netsh advfirewall firewall add rule name="443 UDP" dir=in action=allow protocol=UDP localport=443
cls
netsh advfirewall firewall add rule name="443 TCP" dir=out action=allow protocol=TCP localport=443
cls
netsh advfirewall firewall add rule name="443 UDP" dir=out action=allow protocol=UDP localport=443
cls

netsh advfirewall firewall add rule name="5454 TCP" dir=in action=allow protocol=TCP localport=5454
cls
netsh advfirewall firewall add rule name="5454 UDP" dir=in action=allow protocol=UDP localport=5454
cls
netsh advfirewall firewall add rule name="5454 TCP" dir=out action=allow protocol=TCP localport=5454
cls
netsh advfirewall firewall add rule name="5454 UDP" dir=out action=allow protocol=UDP localport=5454
cls

netsh advfirewall firewall add rule name="30120 TCP" dir=in action=allow protocol=TCP localport=30120
cls
netsh advfirewall firewall add rule name="30120 UDP" dir=in action=allow protocol=UDP localport=30120
cls
netsh advfirewall firewall add rule name="30120 TCP" dir=out action=allow protocol=TCP localport=30120
cls
netsh advfirewall firewall add rule name="30120 UDP" dir=out action=allow protocol=UDP localport=30120
cls


netsh advfirewall firewall add rule name="30120 TCP" dir=in action=allow protocol=TCP localport=10823
cls
netsh advfirewall firewall add rule name="30120 UDP" dir=in action=allow protocol=UDP localport=10823
cls
netsh advfirewall firewall add rule name="30120 TCP" dir=out action=allow protocol=TCP localport=10823
cls
netsh advfirewall firewall add rule name="30120 UDP" dir=out action=allow protocol=UDP localport=10823
cls
