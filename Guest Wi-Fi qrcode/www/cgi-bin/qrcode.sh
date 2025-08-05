#!/bin/sh

#opkg install coreutils-base64 qrencode
# chmod 755
echo "Content-Type: text/html"
echo ""

SSID="$(uci get wireless.guest.ssid)"
PASS="$(uci get wireless.guest.key)"
ENC="$(uci get wireless.guest.encryption)"

case "$ENC" in
  psk*|wpa*) TTYPE="WPA" ;;
  wep)       TTYPE="WEP" ;;
  none)      TTYPE="nopass" ;;
  *)         TTYPE="WPA" ;;
esac

DATA="WIFI:T:$TTYPE;S:$SSID;P:$PASS;;"

QR_BASE64="$(qrencode -t SVG "$DATA" | base64 | tr -d '\n')"

cat <<HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Guest Wi-Fi</title>
  <style>
    body { background:#fff; font-family:Arial,sans-serif; text-align:center; padding:5vh }
    h1   { font-size:50px; margin-bottom:1em }
    img  { width:600px; height:600px; }
    p    { font-size:60px; margin:0.5em 0 }
  </style>
</head>
<body>
  <h1>Guest Wi-Fi</h1>
  <img src="data:image/svg+xml;base64,$QR_BASE64" alt="Wi-Fi QR">
  <p>SSID: <b>$SSID</b></p>
  <p>Hasło: <b>$PASS</b></p>
</body>
</html>
HTML
