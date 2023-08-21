# -*- mode: BSDmakefile; tab-width: 8; indent-tabs-mode: nil -*-

OPENSSL=openssl

ifndef DIR
DIR := .
endif

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
P12PASS := true
else
P12PASS := @echo No PASSWORD defined. && false
endif

ifndef NUMBER_OF_PRIVATE_KEY_BITS
NUMBER_OF_PRIVATE_KEY_BITS := 4096
endif

ifndef DAYS_OF_VALIDITY
DAYS_OF_VALIDITY := 3650
endif

.PRECIOUS: %/testca
.PHONY: %/clean target all p12pass

all: client server copy announce

regen: clean all

info:
	@echo "===> Server certificate details:"
	openssl x509 -in $(SERVER_CERT_LOCATION) -text -noout
	@echo "\n\n===> Client certificate details:"
	openssl x509 -in $(CLIENT_CERT_LOCATION) -text -noout
# $ PASSWORD=bunnies make -n --just-print info
# echo "===> Server certificate details:"
# openssl x509 -in result/server_certificate.pem -text -noout
# echo "\n\n===> Client certificate details:"
# openssl x509 -in result/client_certificate.pem -text -noout
# $


client: p12pass
	@echo Using $(CN) as CN value.
	$(MAKE) target DIR=$(DIR) TARGET=client EXTENSIONS=client_extensions CN=$(CN)
# $ PASSWORD=bunnies make -n --just-print client
# true
# echo Using localhost as CN value.
# /Library/Developer/CommandLineTools/usr/bin/make target DIR=. TARGET=client EXTENSIONS=client_extensions CN=localhost
# mkdir ./testca
# cp openssl.cnf ./testca/openssl.cnf
# { ( cd ./testca && \
# 	    mkdir certs private && \
# 	    chmod 700 private && \
# 	    echo 01 > serial && \
# 	    touch index.txt && \
# 	    openssl req -x509 -days 3650 -config openssl.cnf -newkey rsa:4096 \
# 	      -out cacert.pem -outform PEM -subj /CN=MyTestRootCA/L=$$/ -nodes && \
# 	    openssl x509 -in cacert.pem -out cacert.cer -outform DER ) \
# 	  || (rm -rf testca && false); }
# mkdir ./client
# { ( cd ./client && \
# 	    openssl genrsa -out key.pem 4096 &&\
# 	    openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM\
# 		-subj /CN=localhost/O=client/L=$$/ -nodes &&\
# 	    cd ../testca && \
# 	    openssl ca -config openssl.cnf  -days 3650 -in ../client/req.pem -out \
# 	      ../client/cert.pem -notext -batch -extensions \
# 	      client_extensions && \
# 	    cd ../client && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf ./client && false); }
# $


server: p12pass
	@echo Using $(CN) as CN value.
	$(MAKE) target DIR=$(DIR) TARGET=server EXTENSIONS=server_extensions CN=$(CN)
# $ PASSWORD=bunnies make -n --just-print server
# true
# echo Using localhost as CN value.
# /Library/Developer/CommandLineTools/usr/bin/make target DIR=. TARGET=server EXTENSIONS=server_extensions CN=localhost
# mkdir ./testca
# cp openssl.cnf ./testca/openssl.cnf
# { ( cd ./testca && \
# 	    mkdir certs private && \
# 	    chmod 700 private && \
# 	    echo 01 > serial && \
# 	    touch index.txt && \
# 	    openssl req -x509 -days 3650 -config openssl.cnf -newkey rsa:4096 \
# 	      -out cacert.pem -outform PEM -subj /CN=MyTestRootCA/L=$$/ -nodes && \
# 	    openssl x509 -in cacert.pem -out cacert.cer -outform DER ) \
# 	  || (rm -rf testca && false); }
# mkdir ./server
# { ( cd ./server && \
# 	    openssl genrsa -out key.pem 4096 &&\
# 	    openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM\
# 		-subj /CN=localhost/O=server/L=$$/ -nodes &&\
# 	    cd ../testca && \
# 	    openssl ca -config openssl.cnf  -days 3650 -in ../server/req.pem -out \
# 	      ../server/cert.pem -notext -batch -extensions \
# 	      server_extensions && \
# 	    cd ../server && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf ./server && false); }
# $

# mkdir ./client
# { ( cd ./client && \
# 	    openssl genrsa -out key.pem 4096 &&\
# 	    openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM\
# 		-subj /CN=localhost/O=client/L=$$/ -nodes &&\
# 	    cd ../testca && \
# 	    openssl ca -config openssl.cnf  -days 3650 -in ../client/req.pem -out \
# 	      ../client/cert.pem -notext -batch -extensions \
# 	      client_extensions && \
# 	    cd ../client && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf ./client && false); }

p12pass:
	$(P12PASS)

# make target DIR=. TARGET=client EXTENSIONS=client_extensions CN=localhost
# make target DIR=. TARGET=server EXTENSIONS=server_extensions CN=localhost
target: $(DIR)/testca
	mkdir $(DIR)/$(TARGET)
	{ ( cd $(DIR)/$(TARGET) && \
	    $(OPENSSL) genrsa -out key.pem $(NUMBER_OF_PRIVATE_KEY_BITS) &&\
	    $(OPENSSL) req -new -key key.pem -out req.pem -days $(DAYS_OF_VALIDITY) -outform PEM\
		-subj /CN=$(CN)/O=$(TARGET)/L=$$$$/ -nodes &&\
	    cd ../testca && \
	    $(OPENSSL) ca -config openssl.cnf  -days $(DAYS_OF_VALIDITY) -in ../$(TARGET)/req.pem -out \
	      ../$(TARGET)/cert.pem -notext -batch -extensions \
	      $(EXTENSIONS) && \
	    cd ../$(TARGET) && \
	    $(OPENSSL) pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
	      -passout pass:$(PASSWORD) ) || (rm -rf $(DIR)/$(TARGET) && false); }
# mkdir ./server
# { ( cd ./server && \
# 	    openssl genrsa -out key.pem 4096 &&\
# 	    openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM\
# 		-subj /CN=localhost/O=server/L=$$/ -nodes &&\
# 	    cd ../testca && \
# 	    openssl ca -config openssl.cnf  -days 3650 -in ../server/req.pem -out \
# 	      ../server/cert.pem -notext -batch -extensions \
# 	      server_extensions && \
# 	    cd ../server && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf ./server && false); }



$(DIR)/testca:
	mkdir $(DIR)/testca
	cp openssl.cnf $(DIR)/testca/openssl.cnf
	{ ( cd $(DIR)/testca && \
	    mkdir certs private && \
	    chmod 700 private && \
	    echo 01 > serial && \
	    touch index.txt && \
	    $(OPENSSL) req -x509 -days $(DAYS_OF_VALIDITY) -config openssl.cnf -newkey rsa:$(NUMBER_OF_PRIVATE_KEY_BITS) \
	      -out cacert.pem -outform PEM -subj /CN=MyTestRootCA/L=$$$$/ -nodes && \
	    $(OPENSSL) x509 -in cacert.pem -out cacert.cer -outform DER ) \
	  || (rm -rf $@ && false); }
# mkdir ./testca
# cp openssl.cnf ./testca/openssl.cnf
# { ( cd ./testca && \
# 	    mkdir certs private && \
# 	    chmod 700 private && \
# 	    echo 01 > serial && \
# 	    touch index.txt && \
# 	    openssl req -x509 -days 3650 -config openssl.cnf -newkey rsa:4096 \
# 	      -out cacert.pem -outform PEM -subj /CN=MyTestRootCA/L=$$/ -nodes && \
# 	    openssl x509 -in cacert.pem -out cacert.cer -outform DER ) \
# 	  || (rm -rf testca && false); }

clean:
	rm -rf $(DIR)/testca
	rm -rf $(DIR)/server
	rm -rf $(DIR)/client
	rm -rf $(DIR)/result

CA_CERT_LOCATION     = result/ca_certificate.pem
CLIENT_CERT_LOCATION = result/client_certificate.pem
SERVER_CERT_LOCATION = result/server_certificate.pem

copy:
	mkdir -p result
	cp $(DIR)/testca/cacert.pem        $(CA_CERT_LOCATION)
	cp $(DIR)/testca/private/cakey.pem result/ca_key.pem
	cp $(DIR)/server/cert.pem    $(SERVER_CERT_LOCATION)
	cp $(DIR)/server/key.pem     result/server_key.pem
	cp $(DIR)/server/keycert.p12 result/server_key.p12
	cp $(DIR)/client/cert.pem    $(CLIENT_CERT_LOCATION)
	cp $(DIR)/client/key.pem     result/client_key.pem
	cp $(DIR)/client/keycert.p12 result/client_key.p12

announce:
	$(info Done! Find generated certificates and private keys under ./result!)

verify:
	@echo "Will verify generated certificates against the CA..."
	$(OPENSSL) verify -CAfile $(CA_CERT_LOCATION) $(SERVER_CERT_LOCATION)
	$(OPENSSL) verify -CAfile $(CA_CERT_LOCATION) $(CLIENT_CERT_LOCATION)

verify-pkcs12:
	@echo "Will verify PKCS12 stores..."
	keytool -v -list -storetype pkcs12 -keystore result/server_key.p12
	keytool -v -list -storetype pkcs12 -keystore result/client_key.p12
