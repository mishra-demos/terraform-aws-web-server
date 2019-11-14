#!/bin/bash

#!/bin/bash

export IP_ADDRESS=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

apt-get update
# Install packages
apt-get install -y unzip dnsmasq vim

curl \
  --silent \
  --location \
  --output ${service_name}.zip \
  ${standalone_binary_url}

unzip ${service_name}.zip
mv ${service_name} /usr/local/bin/${service_name}
rm ${service_name}.zip

sudo tee /etc/systemd/system/${service_name}.service > /dev/null <<EOF
[Unit]
Description=${service_name}
Requires=network-online.target
After=network-online.target

[Service]
Environment=PORT=${service_port}
ExecStart=/usr/local/bin/${service_name}
ExecReload=/bin/kill -HUP $MAINPID
KillSignal=SIGINT
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

echo "--> Enabling ${service_name} service"
sudo systemctl enable ${service_name}

echo "Setting hostname....."
sudo tee /etc/hostname > /dev/null <<"EOF"
${hostname}
EOF
sudo hostname -F /etc/hostname
sudo tee -a /etc/hosts > /dev/null <<EOF
# For local resolution
$IP_ADDRESS  ${hostname}
EOF

systemctl start ${service_name}