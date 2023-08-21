/* -*- mode: BSDmakefile; tab-width: 8; indent-tabs-mode: nil -*- */

OPENSSL=openssl

ifndef DIR
DIR := .
endif

ifdef PASSWORD
P12PASS := true
else
P12PASS := @echo No PASSWORD defined. && false
endif

.PRECIOUS: %/testca
.PHONY: %/clean target all p12pass

all: client server copy

regen: clean all

client: p12pass
	echo $(DIR)
	$(MAKE) target DIR=$(DIR) TARGET=client EXTENSIONS=client_ca_extensions
# $ PASSWORD=bunnies make -n --just-print client
# true
# echo .
# /Library/Developer/CommandLineTools/usr/bin/make target DIR=. TARGET=client EXTENSIONS=client_ca_extensions
# mkdir ./testca
# cp openssl.cnf ./testca/openssl.cnf
# { ( cd ./testca && \
# 	    mkdir certs private && \
# 	    chmod 700 private && \
# 	    echo 01 > serial && \
# 	    touch index.txt && \
# 	    openssl req -x509 -config openssl.cnf -newkey rsa:2048 \
# 	      -out cacert.pem -outform PEM -subj /CN=MyTestCA/L=$$/ -nodes && \
# 	    openssl x509 -in cacert.pem -out cacert.cer -outform DER ) \
# 	  || (rm -rf testca && false); }
# mkdir ./client
# { ( cd ./client && \
# 	    openssl genrsa -out key.pem 2048 &&\
# 	    openssl req -new -key key.pem -out req.pem -outform PEM\
# 		-subj /CN=$(hostname)/O=client/L=$$/ -nodes &&\
# 	    cd ../testca && \
# 	    openssl ca -config openssl.cnf -in ../client/req.pem -out \
# 	      ../client/cert.pem -notext -batch -extensions \
# 	      client_ca_extensions && \
# 	    cd ../client && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf ./client && false); }
# $


server: p12pass
	$(MAKE) target DIR=$(DIR) TARGET=server EXTENSIONS=server_ca_extensions
# $ PASSWORD=bunnies make -n --just-print server
# true
# /Library/Developer/CommandLineTools/usr/bin/make target DIR=. TARGET=server EXTENSIONS=server_ca_extensions
# mkdir ./testca
# cp openssl.cnf ./testca/openssl.cnf
# { ( cd ./testca && \
# 	    mkdir certs private && \
# 	    chmod 700 private && \
# 	    echo 01 > serial && \
# 	    touch index.txt && \
# 	    openssl req -x509 -config openssl.cnf -newkey rsa:2048 \
# 	      -out cacert.pem -outform PEM -subj /CN=MyTestCA/L=$$/ -nodes && \
# 	    openssl x509 -in cacert.pem -out cacert.cer -outform DER ) \
# 	  || (rm -rf testca && false); }
# mkdir ./server
# { ( cd ./server && \
# 	    openssl genrsa -out key.pem 2048 &&\
# 	    openssl req -new -key key.pem -out req.pem -outform PEM\
# 		-subj /CN=$(hostname)/O=server/L=$$/ -nodes &&\
# 	    cd ../testca && \
# 	    openssl ca -config openssl.cnf -in ../server/req.pem -out \
# 	      ../server/cert.pem -notext -batch -extensions \
# 	      server_ca_extensions && \
# 	    cd ../server && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf ./server && false); }
# $


p12pass:
	$(P12PASS)


# make target DIR=. TARGET=client EXTENSIONS=client_ca_extensions
# make target DIR=. TARGET=server EXTENSIONS=server_ca_extensions
target: $(DIR)/testca
	mkdir $(DIR)/$(TARGET)
	{ ( cd $(DIR)/$(TARGET) && \
	    openssl genrsa -out key.pem 2048 &&\
	    openssl req -new -key key.pem -out req.pem -outform PEM\
		-subj /CN=$$(hostname)/O=$(TARGET)/L=$$$$/ -nodes &&\
	    cd ../testca && \
	    openssl ca -config openssl.cnf -in ../$(TARGET)/req.pem -out \
	      ../$(TARGET)/cert.pem -notext -batch -extensions \
	      $(EXTENSIONS) && \
	    cd ../$(TARGET) && \
	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
	      -passout pass:$(PASSWORD) ) || (rm -rf $(DIR)/$(TARGET) && false); }
# mkdir ./client
# { ( cd ./client && \
# 	    openssl genrsa -out key.pem 2048 &&\
# 	    openssl req -new -key key.pem -out req.pem -outform PEM\
# 		-subj /CN=$(hostname)/O=client/L=$$/ -nodes &&\
# 	    cd ../testca && \
# 	    openssl ca -config openssl.cnf -in ../client/req.pem -out \
# 	      ../client/cert.pem -notext -batch -extensions \
# 	      client_ca_extensions && \
# 	    cd ../client && \
# 	    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem \
# 	      -passout pass:bunnies ) || (rm -rf ./client && false); }

# $ mkdir ./client

# $ cd ./client

# $ openssl genrsa -out key.pem 2048
# Generating RSA private key, 2048 bit long modulus
# ...................+++
# ..............+++
# e is 65537 (0x10001)

# $ openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=$(hostname)/O=client/L=$$/ -nodes

# $ tree -a .
# .
# ├── key.pem
# └── req.pem

# 0 directories, 2 files

# $ cd ../testca

# $ openssl ca -config openssl.cnf -in ../client/req.pem -out ../client/cert.pem -notext -batch -extensions client_ca_extensions
# Using configuration from openssl.cnf
# Check that the request matches the signature
# Signature ok
# The Subject's Distinguished Name is as follows
# commonName            :ASN.1 12:'localhost'
# organizationName      :ASN.1 12:'client'
# localityName          :ASN.1 12:'649'
# Certificate is to be certified until Aug 19 10:33:35 2028 GMT (1825 days)

# Write out database with 1 new entries
# Data Base Updated

# $ cd ../client

# $ openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem -passout pass:bunnies

###################################################################################################################

# mkdir ./server
# { ( cd ./server && \
# 	    openssl genrsa -out key.pem 2048 &&\
# 	    openssl req -new -key key.pem -out req.pem -outform PEM\
# 		-subj /CN=$(hostname)/O=server/L=$$/ -nodes &&\
# 	    cd ../testca && \
# 	    openssl ca -config openssl.cnf -in ../server/req.pem -out \
# 	      ../server/cert.pem -notext -batch -extensions \
# 	      server_ca_extensions && \
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
	    openssl req -x509 -config openssl.cnf -newkey rsa:2048 \
	      -out cacert.pem -outform PEM -subj /CN=MyTestCA/L=$$$$/ -nodes && \
	    openssl x509 -in cacert.pem -out cacert.cer -outform DER ) \
	  || (rm -rf $@ && false); }
# mkdir ./testca
# cp openssl.cnf ./testca/openssl.cnf
# { ( cd ./testca && \
# 	    mkdir certs private && \
# 	    chmod 700 private && \
# 	    echo 01 > serial && \
# 	    touch index.txt && \
# 	    openssl req -x509 -config openssl.cnf -newkey rsa:2048 \
# 	      -out cacert.pem -outform PEM -subj /CN=MyTestCA/L=$$/ -nodes && \
# 	    openssl x509 -in cacert.pem -out cacert.cer -outform DER ) \
# 	  || (rm -rf testca && false); }

# $ mkdir ./testca

# $ cp openssl.cnf ./testca/openssl.cnf

# $ cd ./testca

# $ ll
# total 8
# drwxr-xr-x  3 huzhi  staff    96  8 21 18:18 ./
# drwxr-xr-x  8 huzhi  staff   256  8 21 18:18 ../
# -rw-r--r--  1 huzhi  staff  1134  8 21 18:18 openssl.cnf

# $ mkdir certs private

# $ tree -a .
# .
# ├── certs
# ├── openssl.cnf
# └── private

# 2 directories, 1 file

# $ chmod 700 private

# $ echo 01 > serial

# $ tree -a .
# .
# ├── certs
# ├── openssl.cnf
# ├── private
# └── serial

# 2 directories, 2 files

# $ touch index.txt

# $ tree -a .
# .
# ├── certs
# ├── index.txt
# ├── openssl.cnf
# ├── private
# └── serial

# 2 directories, 3 files

# Country Name (2 letter code) [AU]:CN #国家
# State or Province Name (full name) [Some-State]:hubeisheng # 省份
# Locality Name (eg, city) []:wuhanshi # 城市
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:wuhan antiy # 公司名称
# Organizational Unit Name (eg, section) []:Technical Support # 公司部门
# Common Name (e.g. server FQDN or YOUR name) []:www.antiy.com # 公司完整域名
# Email Address []:huzhi@antiy.cn # 联系人邮箱

# Subject: C=CN, ST=hubeisheng, L=wuhanshi, O=wuhan antiy, OU=Technical Support, CN=www.antiy.com/emailAddress=huzhi@antiy.cn

# $ openssl req -x509 -config openssl.cnf -newkey rsa:2048 -out cacert.pem -outform PEM -subj /CN=MyTestCA/L=$$/ -nodes
# Generating a 2048 bit RSA private key
# ....................................................................................................+++
# ......+++
# writing new private key to './private/cakey.pem'
# -----

# $ tree -a .
# .
# ├── cacert.pem
# ├── certs
# ├── index.txt
# ├── openssl.cnf
# ├── private
# │   └── cakey.pem
# └── serial

# 2 directories, 5 files

# $ openssl x509 -in cacert.pem -out cacert.cer -outform DER

# $ tree -a .
# .
# ├── cacert.cer
# ├── cacert.pem
# ├── certs
# ├── index.txt
# ├── openssl.cnf
# ├── private
# │   └── cakey.pem
# └── serial

# 2 directories, 6 files

# $ openssl x509 -in cacert.pem -noout -text
# Certificate:
#     Data:
#         Version: 3 (0x2)
#         Serial Number: 14594915770116250039 (0xca8b8e90d48699b7)
#     Signature Algorithm: sha1WithRSAEncryption
#         Issuer: CN=MyTestCA, L=649
#         Validity
#             Not Before: Aug 21 10:23:56 2023 GMT
#             Not After : Sep 20 10:23:56 2023 GMT
#         Subject: CN=MyTestCA, L=649
#         Subject Public Key Info:
#             Public Key Algorithm: rsaEncryption
#                 Public-Key: (2048 bit)
#                 Modulus:
#                     00:e6:c4:8e:e1:0c:cb:d7:2e:0f:19:5d:02:cc:d8:
#                     2e:f0:4a:5f:bd:ac:f3:0b:ba:92:40:1d:1b:bb:8f:
#                     3c:36:d0:25:3d:df:1a:a9:21:f6:84:dd:a7:1f:72:
#                     16:aa:a8:a1:de:ad:3c:fa:cb:ac:57:0d:81:56:d9:
#                     be:05:df:e2:e5:7c:30:60:fc:ed:0d:2b:2d:8c:85:
#                     4b:bb:05:8d:53:9c:fc:6b:b3:8b:0d:2a:7a:72:33:
#                     ef:44:ac:48:22:67:30:e7:0d:03:2e:62:8b:c0:32:
#                     41:72:93:2f:5c:27:cc:8a:dc:72:05:5f:46:50:2e:
#                     62:14:57:3e:ae:07:60:3c:82:14:46:2b:dc:1e:35:
#                     98:34:58:a2:13:11:56:4d:34:3c:91:de:68:7e:ef:
#                     c3:45:6d:2a:b7:1a:2c:b6:c2:9d:90:e2:cf:3f:77:
#                     3d:e4:c4:a5:17:ce:42:ac:1b:10:e0:86:19:02:4e:
#                     44:dd:d9:6c:69:82:ea:ba:4e:18:b5:b5:e9:0f:32:
#                     c0:79:bd:a5:d5:c8:b8:df:e5:83:97:ac:53:c1:ad:
#                     e2:90:92:0b:98:54:0c:b4:83:11:a0:15:31:84:2b:
#                     af:a9:54:7f:f2:29:40:8d:8f:e6:79:6d:8b:f2:47:
#                     02:e1:b9:cf:90:f7:79:65:64:27:19:b7:f1:52:55:
#                     2c:21
#                 Exponent: 65537 (0x10001)
#         X509v3 extensions:
#             X509v3 Basic Constraints:
#                 CA:TRUE
#             X509v3 Key Usage:
#                 Certificate Sign, CRL Sign
#     Signature Algorithm: sha1WithRSAEncryption
#          03:5b:34:c7:a7:e4:c6:b2:c3:f6:16:04:9e:a5:35:c6:f4:49:
#          f0:e3:17:68:6c:65:cb:6e:a4:a2:c1:6c:6a:79:bd:a2:fc:dd:
#          bb:86:56:fd:4c:5a:8d:03:f6:a1:3d:08:ff:7d:09:3b:49:77:
#          d2:89:b2:ed:64:75:07:69:04:13:37:5d:5e:38:4f:f3:5b:11:
#          19:ec:d7:63:44:10:92:40:89:5c:08:59:61:b6:07:7d:9f:b6:
#          2c:a2:83:e1:3e:68:04:c4:03:b6:f2:3b:e6:f9:13:b2:1b:cc:
#          16:7c:f1:6d:bc:44:da:e3:ee:16:2d:da:c4:75:52:3d:b3:04:
#          37:a2:7b:a4:04:ec:65:ae:96:b3:de:b4:5d:c2:8f:90:d4:b7:
#          bc:46:7c:ab:aa:8e:06:97:83:ab:3e:ec:8c:6e:95:b3:06:ae:
#          00:68:35:d2:ef:a4:1e:9b:09:1a:8e:b6:c7:eb:04:a7:40:89:
#          b4:ea:c6:45:17:48:d9:63:9d:65:69:de:a7:d0:b1:02:3a:5c:
#          98:2c:31:25:99:26:3a:ce:22:dd:eb:01:a0:79:77:5d:28:fc:
#          81:c3:31:c4:1b:4c:dc:4b:f9:24:8b:5f:38:2e:77:da:7a:7a:
#          6f:7a:13:b2:fd:e7:67:56:fb:9e:ad:45:7f:df:10:66:1d:c8:
#          be:07:a4:9d
# $

clean:
	rm -rf $(DIR)/testca
	rm -rf $(DIR)/server
	rm -rf $(DIR)/client
	rm -rf $(DIR)/result

copy:
	mkdir -p result
	cp $(DIR)/testca/cacert.pem result/ca_certificate.pem
	cp $(DIR)/server/cert.pem   result/server_certificate.pem
	cp $(DIR)/server/key.pem    result/server_key.pem
	cp $(DIR)/client/cert.pem   result/client_certificate.pem
	cp $(DIR)/client/key.pem    result/client_key.pem
