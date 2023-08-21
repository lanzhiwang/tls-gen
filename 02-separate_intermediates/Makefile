# -*- mode: BSDmakefile; tab-width: 8; indent-tabs-mode: nil -*-

OPENSSL=openssl

ifndef DIR
DIR := $(shell pwd)
endif
# DIR: /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates

# Country Name (2 letter code) [AU]:CN #国家
# State or Province Name (full name) [Some-State]:hubeisheng # 省份
# Locality Name (eg, city) []:wuhanshi # 城市
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:wuhan antiy # 公司名称
# Organizational Unit Name (eg, section) []:Technical Support # 公司部门
# Common Name (e.g. server FQDN or YOUR name) []:www.antiy.com # 公司完整域名
# Email Address []:huzhi@antiy.cn # 联系人邮箱

# Subject: C=CN, ST=hubeisheng, L=wuhanshi, O=wuhan antiy, OU=Technical Support, CN=www.antiy.com/emailAddress=huzhi@antiy.cn

ifndef CN
CN := $(shell hostname)
endif

ifdef PASSWORD
ENSURE_PASSPHRASE := true
else
ENSURE_PASSPHRASE := @echo No PASSWORD defined. && false
endif

ifndef NUMBER_OF_PRIVATE_KEY_BITS
NUMBER_OF_PRIVATE_KEY_BITS := 4096
endif

ifndef DAYS_OF_VALIDITY
DAYS_OF_VALIDITY := 3650
endif

.PRECIOUS: %/root_ca
.PHONY: %/clean target all ensure_passphrase

all: cas client server copy announce

regen: clean all

cas: ensure_passphrase root_ca intermediate_server_ca intermediate_client_ca concat

client: ensure_passphrase
	@echo Using $(CN) as CN value.
	$(MAKE) target DIR=$(DIR) TARGET=client EXTENSIONS=client_extensions CN=$(CN)
# $ PASSWORD=bunnies make -n --just-print client
# true
# echo Using localhost as CN value.
# /Library/Developer/CommandLineTools/usr/bin/make target DIR=/Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates TARGET=client EXTENSIONS=client_extensions CN=localhost
# true

# mkdir /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca
# cp openssl.cnf /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/openssl.cnf
# { ( cd /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca && \
# 	    mkdir certs private && \
# 	    chmod 700 private && \
# 	    echo 01 > serial && \
# 	    touch index.txt && \
# 	    openssl genrsa -out /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/private/root_ca_key.pem 4096 && \
# 	    openssl req -x509 -config openssl.cnf -new \
# 		-key /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/private/root_ca_key.pem \
# 		-out /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem -subj /CN=MyTestRootCA/ && \
# 	    openssl x509 -days 3650 \
# 			-in /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem \
#                         -out certs/root_ca_certificate.cer \
# 			-outform DER -extensions ca_extensions ) || (rm -rf root_ca && false); }

# cat /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_server_ca/certs/cacert.pem /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem > /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_server_ca/certs/server_and_root_chained_certificate.pem

# cat /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/cacert.pem /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem > /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/client_and_root_chained_certificate.pem

# mkdir /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/client
# { ( cd /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/client && \
# 	    openssl genrsa -out key.pem 4096 &&\
# 	    openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM\
# 		-subj /CN=localhost/O=client/L=$$/ -nodes && \
# 	    cd ../intermediate_client_ca && \
# 	    openssl ca -config openssl.cnf  -days 3650 -in ../client/req.pem \
# 	        -out ../client/cert.pem \
# 		-key /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/private/cakey.pem -cert /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/cacert.pem \
# 	        -notext -batch -extensions client_extensions && \
# 	    cd ../client && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/client && false); }
# $

server: ensure_passphrase
	@echo Using $(CN) as CN value.
	$(MAKE) target DIR=$(DIR) TARGET=server EXTENSIONS=server_extensions CN=$(CN)

ensure_passphrase:
	$(ENSURE_PASSPHRASE)

ROOT_CA_KEY  = $(DIR)/root_ca/private/root_ca_key.pem
ROOT_CA_CERT = $(DIR)/root_ca/certs/root_ca_certificate.pem
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem

# make target DIR=/Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates TARGET=client EXTENSIONS=client_extensions CN=localhost
target: cas
	mkdir $(DIR)/$(TARGET)
	{ ( cd $(DIR)/$(TARGET) && \
	    $(OPENSSL) genrsa -out key.pem $(NUMBER_OF_PRIVATE_KEY_BITS) &&\
	    $(OPENSSL) req -new -key key.pem -out req.pem -days $(DAYS_OF_VALIDITY) -outform PEM\
		-subj /CN=$(CN)/O=$(TARGET)/L=$$$$/ -nodes && \
	    cd ../intermediate_$(TARGET)_ca && \
	    $(OPENSSL) ca -config openssl.cnf  -days $(DAYS_OF_VALIDITY) -in ../$(TARGET)/req.pem \
	        -out ../$(TARGET)/cert.pem \
		-key $(DIR)/intermediate_$(TARGET)_ca/private/cakey.pem -cert $(DIR)/intermediate_$(TARGET)_ca/certs/cacert.pem \
	        -notext -batch -extensions $(EXTENSIONS) && \
	    cd ../$(TARGET) && \
	    $(OPENSSL) pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
	      -passout pass:$(PASSWORD) ) || (rm -rf $(DIR)/$(TARGET) && false); }
# mkdir /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/client
# { ( cd /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/client && \
# 	    openssl genrsa -out key.pem 4096 &&\
# 	    openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM\
# 		-subj /CN=localhost/O=client/L=$$/ -nodes && \
# 	    cd ../intermediate_client_ca && \
# 	    openssl ca -config openssl.cnf  -days 3650 -in ../client/req.pem \
# 	        -out ../client/cert.pem \
# 		-key /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/private/cakey.pem -cert /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/cacert.pem \
# 	        -notext -batch -extensions client_extensions && \
# 	    cd ../client && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/client && false); }

# mkdir /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/client

# cd /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/client

# openssl genrsa -out key.pem 4096

# openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM -subj /CN=localhost/O=client/L=$$/ -nodes

# cd ../intermediate_client_ca

# openssl ca -config openssl.cnf  -days 3650 -in ../client/req.pem -out ../client/cert.pem -key /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/private/cakey.pem -cert /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/cacert.pem -notext -batch -extensions client_extensions

# cd ../client

# openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem -passout pass:bunnies


root_ca:
	mkdir $(DIR)/root_ca
	cp openssl.cnf $(DIR)/root_ca/openssl.cnf
	{ ( cd $(DIR)/root_ca && \
	    mkdir certs private && \
	    chmod 700 private && \
	    echo 01 > serial && \
	    touch index.txt && \
	    $(OPENSSL) genrsa -out $(ROOT_CA_KEY) $(NUMBER_OF_PRIVATE_KEY_BITS) && \
	    $(OPENSSL) req -x509 -config openssl.cnf -new \
		-key $(ROOT_CA_KEY) \
		-out $(ROOT_CA_CERT) -subj /CN=MyTestRootCA/ && \
	    $(OPENSSL) x509 -days $(DAYS_OF_VALIDITY) \
			-in $(ROOT_CA_CERT) \
                        -out certs/root_ca_certificate.cer \
			-outform DER -extensions ca_extensions ) || (rm -rf $@ && false); }
# $ PASSWORD=bunnies make -n --just-print root_ca
# mkdir /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca
# cp openssl.cnf /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/openssl.cnf
# { ( cd /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca && \
# 	    mkdir certs private && \
# 	    chmod 700 private && \
# 	    echo 01 > serial && \
# 	    touch index.txt && \
# 	    openssl genrsa -out /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/private/root_ca_key.pem 4096 && \
# 	    openssl req -x509 -config openssl.cnf -new \
# 		-key /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/private/root_ca_key.pem \
# 		-out /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem -subj /CN=MyTestRootCA/ && \
# 	    openssl x509 -days 3650 \
# 			-in /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem \
#                         -out certs/root_ca_certificate.cer \
# 			-outform DER -extensions ca_extensions ) || (rm -rf root_ca && false); }
# $

# mkdir /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca

# cp openssl.cnf /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/openssl.cnf

# cd /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca

# mkdir certs private

# chmod 700 private

# echo 01 > serial

# touch index.txt

# openssl genrsa -out /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/private/root_ca_key.pem 4096

# openssl req -x509 -config openssl.cnf -new -key /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/private/root_ca_key.pem -out /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem -subj /CN=MyTestRootCA/

# openssl x509 -days 3650 -in /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem -out certs/root_ca_certificate.cer -outform DER -extensions ca_extensions


SERVER_INTERMEDIATE_CA_DIR  = intermediate_server_ca
SERVER_INTERMEDIATE_CA_PATH = $(DIR)/$(SERVER_INTERMEDIATE_CA_DIR)
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_server_ca

CLIENT_INTERMEDIATE_CA_DIR  = intermediate_client_ca
CLIENT_INTERMEDIATE_CA_PATH = $(DIR)/$(CLIENT_INTERMEDIATE_CA_DIR)
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca

SERVER_INTERMEDIATE_CA_KEY  = $(SERVER_INTERMEDIATE_CA_PATH)/private/cakey.pem
SERVER_INTERMEDIATE_CA_CERT = $(SERVER_INTERMEDIATE_CA_PATH)/certs/cacert.pem
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_server_ca/certs/cacert.pem

CLIENT_INTERMEDIATE_CA_KEY  = $(CLIENT_INTERMEDIATE_CA_PATH)/private/cakey.pem
CLIENT_INTERMEDIATE_CA_CERT = $(CLIENT_INTERMEDIATE_CA_PATH)/certs/cacert.pem
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/cacert.pem

SERVER_ROOT_CHAINED_CERT    = $(SERVER_INTERMEDIATE_CA_PATH)/certs/server_and_root_chained_certificate.pem
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_server_ca/certs/server_and_root_chained_certificate.pem

CLIENT_ROOT_CHAINED_CERT    = $(CLIENT_INTERMEDIATE_CA_PATH)/certs/client_and_root_chained_certificate.pem
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/client_and_root_chained_certificate.pem

intermediate_server_ca:
	@echo "Will generate server intermediate CA"
	$(MAKE) intermediate_ca SUFFIX=server PARENT_KEY=$(ROOT_CA_KEY) PARENT_CERT=$(ROOT_CA_CERT) DIR=$(DIR) CN=MyServerCA
	@echo "\n\nWill verify server intermediate CA"
	$(OPENSSL) verify -CAfile $(ROOT_CA_CERT) $(SERVER_INTERMEDIATE_CA_CERT)
	@echo "\n\n----------------------------------------------------------------------------------------------\n\n"

intermediate_client_ca:
	@echo "Will generate client intermediate CA"
	$(MAKE) intermediate_ca SUFFIX=client PARENT_KEY=$(ROOT_CA_KEY) PARENT_CERT=$(ROOT_CA_CERT) DIR=$(DIR) CN=MyClientCA
	@echo "\n\nWill verify client intermediate CA"
	$(OPENSSL) verify -CAfile $(ROOT_CA_CERT) $(CLIENT_INTERMEDIATE_CA_CERT)
	@echo "\n\n----------------------------------------------------------------------------------------------\n\n"

intermediate_ca:
	mkdir $(DIR)/intermediate_$(SUFFIX)_ca
	cp openssl.cnf $(DIR)/intermediate_$(SUFFIX)_ca/openssl.cnf
	{ ( cd $(DIR)/intermediate_$(SUFFIX)_ca && \
	    mkdir certs private && \
	    chmod 700 private && \
	    echo 01 > serial && \
	    touch index.txt && \
	    $(OPENSSL) genrsa -out $(DIR)/intermediate_$(SUFFIX)_ca/private/cakey.pem $(NUMBER_OF_PRIVATE_KEY_BITS) && \
	    $(OPENSSL) req -config openssl.cnf -new \
	            -key $(DIR)/intermediate_$(SUFFIX)_ca/private/cakey.pem \
	            -out $(DIR)/intermediate_$(SUFFIX)_ca/certs/ca_csr.pem \
		    -passin pass:$(PASSWORD) \
		    -subj /CN=$(CN)/O=$(TARGET)/L=$$$$/ && \
	   $(OPENSSL) ca -config openssl.cnf -days $(DAYS_OF_VALIDITY) \
		           -keyfile $(PARENT_KEY) \
		           -cert    $(PARENT_CERT) \
		           -in      $(DIR)/intermediate_$(SUFFIX)_ca/certs/ca_csr.pem \
		           -out     $(DIR)/intermediate_$(SUFFIX)_ca/certs/cacert.pem \
		           -notext -md sha1 -batch -extensions ca_extensions ) || (rm -rf $@ &&  false); }

concat: 
	cat $(SERVER_INTERMEDIATE_CA_CERT) $(ROOT_CA_CERT) > $(SERVER_ROOT_CHAINED_CERT)
	cat $(CLIENT_INTERMEDIATE_CA_CERT) $(ROOT_CA_CERT) > $(CLIENT_ROOT_CHAINED_CERT)
# cat /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_server_ca/certs/cacert.pem /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem > /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_server_ca/certs/server_and_root_chained_certificate.pem

# cat /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/cacert.pem /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/root_ca/certs/root_ca_certificate.pem > /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/separate_intermediates/intermediate_client_ca/certs/client_and_root_chained_certificate.pem

clean:
	rm -rf $(DIR)/root_ca
	rm -rf $(SERVER_INTERMEDIATE_CA_PATH)
	rm -rf $(CLIENT_INTERMEDIATE_CA_PATH)
	rm -rf $(DIR)/server
	rm -rf $(DIR)/client
	rm -rf $(DIR)/result

ROOT_CA_CERT_LOCATION = result/root_ca_certificate.pem
ROOT_CA_KEY_LOCATION  = result/root_ca_key.pem

INTERMEDIATE_SERVER_CA_CERT_LOCATION = result/intermediate_server_ca_certificate.pem
INTERMEDIATE_SERVER_CA_KEY_LOCATION  = result/intermediate_client_ca_key.pem

INTERMEDIATE_CLIENT_CA_CERT_LOCATION = result/intermediate_client_ca_certificate.pem
INTERMEDIATE_CLIENT_CA_KEY_LOCATION  = result/intermediate_client_ca_key.pem

CHAINED_SERVER_CA_CERTIFICATE_LOCATION = result/server_ca_chained_certificate.pem
CHAINED_CLIENT_CA_CERTIFICATE_LOCATION = result/client_ca_chained_certificate.pem

CLIENT_CERT_LOCATION  = result/client_certificate.pem
SERVER_CERT_LOCATION  = result/server_certificate.pem

copy:
	mkdir -p result
	cp $(ROOT_CA_CERT) $(ROOT_CA_CERT_LOCATION)
	cp $(ROOT_CA_KEY)  $(ROOT_CA_KEY_LOCATION)

	cp $(SERVER_INTERMEDIATE_CA_CERT) $(INTERMEDIATE_SERVER_CA_CERT_LOCATION)
	cp $(SERVER_INTERMEDIATE_CA_KEY)  $(INTERMEDIATE_SERVER_CA_KEY_LOCATION)

	cp $(CLIENT_INTERMEDIATE_CA_CERT) $(INTERMEDIATE_CLIENT_CA_CERT_LOCATION)
	cp $(CLIENT_INTERMEDIATE_CA_KEY)  $(INTERMEDIATE_CLIENT_CA_KEY_LOCATION)

	cp $(SERVER_ROOT_CHAINED_CERT)    $(CHAINED_SERVER_CA_CERTIFICATE_LOCATION)
	cp $(CLIENT_ROOT_CHAINED_CERT)    $(CHAINED_CLIENT_CA_CERTIFICATE_LOCATION)

	cp $(DIR)/server/cert.pem    $(SERVER_CERT_LOCATION)
	cp $(DIR)/server/key.pem     result/server_key.pem
	cp $(DIR)/server/keycert.p12 result/server_key.p12
	cp $(DIR)/client/cert.pem    $(CLIENT_CERT_LOCATION)
	cp $(DIR)/client/key.pem     result/client_key.pem
	cp $(DIR)/client/keycert.p12 result/client_key.p12

announce:
	$(info Done! Find generated certificates and private keys under ./result!)

verify:
	@echo "Will verify generated certificates against their respective CAs..."
	$(OPENSSL) verify -CAfile $(CHAINED_SERVER_CA_CERTIFICATE_LOCATION) $(SERVER_CERT_LOCATION)
	$(OPENSSL) verify -CAfile $(CHAINED_CLIENT_CA_CERTIFICATE_LOCATION) $(CLIENT_CERT_LOCATION)

verify-pkcs12:
	@echo "Will verify PKCS12 stores..."
	keytool -v -list -storetype pkcs12 -keystore result/server_key.p12
	keytool -v -list -storetype pkcs12 -keystore result/client_key.p12
