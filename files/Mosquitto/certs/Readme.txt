# Ernie's OpenSSL Cert Kit for Mosquitto
########################################

# Gen the CA
openssl req -out ca.pem -new -x509 -days 3650 -subj '/C=US/ST=Pennsylvania/L=Landenberg/O=IoT/OU=MQTT/CN=localhost/emailAddress=ErnestGWilsonII@gmail.com'
s0undgard3n
s0undgard3n

# Remove the password
openssl rsa -in privkey.pem -out no-password-ca_privkey.pem
s0undgard3n
mv privkey.pem password-protected-ca_privkey.pem


# Gen the server cert
openssl genrsa -out localhost.key 1024

openssl rsa -in localhost.key -text > privkey.pem

openssl req -key localhost.key -new -out server.csr -days 3650 -subj '/C=US/ST=Pennsylvania/L=Landenberg/O=IoT/OU=MQTT/CN=localhost/emailAddress=ErnestGWilsonII@gmail.com'

openssl x509 -req -in server.csr -CA ca.pem -CAkey no-password-ca_privkey.pem -CAcreateserial -out cert.pem -days 3650


# Verify the certs
keytool -printcert -file cert.pem
keytool -printcert -file ca.pem

openssl x509 -in ca.pem -text
openssl x509 -in cert.pem -text

openssl verify ca.pem
openssl verify cert.pem

openssl rsa -noout -text -in privkey.pem
openssl rsa -noout -check -in privkey.pem

