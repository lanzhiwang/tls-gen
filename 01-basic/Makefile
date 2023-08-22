# -*- mode: BSDmakefile; tab-width: 8; indent-tabs-mode: nil -*-

OPENSSL=openssl

ifndef DIR
DIR := .
endif

ifndef CN
CN := $(shell hostname)
endif
# CN: localhost

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

p12pass:
	$(P12PASS)

# PASSWORD=bunnies make target DIR=. TARGET=client EXTENSIONS=client_extensions CN=localhost
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

##################################################################################

# mkdir ./client
# cd ./client
# openssl genrsa -out key.pem 4096
# openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM -subj /CN=localhost/O=client/L=$$/ -nodes
# cd ../testca
# openssl ca -config openssl.cnf  -days 3650 -in ../client/req.pem -out ../client/cert.pem -notext -batch -extensions client_extensions
# cd ../client
# openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem -passout pass:bunnies

# $ pwd
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/01-basic/client

# $ tree -a .
# .
# ├── cert.pem
# ├── key.pem
# ├── keycert.p12
# └── req.pem

# 0 directories, 4 files
# $

##################################################################################

# openssl genrsa -out key.pem 4096
# 这个 OpenSSL 命令用于生成一个新的 RSA 私钥，并将其保存到名为 "key.pem" 的文件中。让我解释一下每个参数的作用：

# - `openssl genrsa`: 这个命令用于生成 RSA 密钥对。

# - `-out key.pem`: 这个选项指定生成的私钥文件的输出路径和文件名。在这个例子中，生成的私钥将保存在名为 "key.pem" 的文件中。

# - `4096`: 这个参数指定生成的私钥的位数，即密钥长度。在这个例子中，生成的 RSA 私钥将有 4096 位长度。

# 综上所述，这个命令将生成一个包含 4096 位长度的 RSA 私钥，并将其保存在名为 "key.pem" 的文件中。这个私钥可以用于加密、解密、数字签名等各种加密通信和身份验证操作。

# openssl req -new -key key.pem -out req.pem -days 3650 -outform PEM -subj /CN=localhost/O=client/L=$$/ -nodes
# 这个 OpenSSL 命令用于生成证书签发请求(Certificate Signing Request, CSR), 以便后续可以由证书颁发机构(CA)生成一个证书。让我解释一下每个参数的作用：

# - `openssl req`: 这是 OpenSSL 工具的主命令，用于处理证书签发请求和相关操作。

# - `-new`: 这个选项指示 OpenSSL 生成一个新的证书签发请求。

# - `-key key.pem`: 这个选项指定使用名为 "key.pem" 的私钥文件来生成证书签发请求。

# - `-out req.pem`: 这个选项指定生成的证书签发请求的输出路径和文件名。在这个例子中，生成的请求将保存在名为 "req.pem" 的文件中。

# - `-days 3650`: 这个选项指定证书签发请求的有效期为 3650 天, 即10年。

# - `-outform PEM`: 这个选项指定输出的请求格式为 PEM 格式，它是一种常见的文本格式用于表示证书和私钥。

# - `-subj /CN=localhost/O=client/L=$$/`: 这个选项设置证书签发请求的主题字段(Subject)。在这个例子中，请求的主题设置为 Common Name (CN) 为 "localhost",Organization (O) 为 "client", Location (L) 字段为空。

# - `-nodes`: 这个选项指示 OpenSSL 在生成私钥时不加密它。这意味着私钥将不使用密码进行保护。

# 综上所述，这个命令将使用给定的私钥文件 "key.pem" 生成一个证书签发请求，请求的主题信息包括 Common Name、Organization 等字段。生成的请求将在 "req.pem" 文件中保存，可以提交给证书颁发机构以获取相应的证书。

##################################################################################

# openssl ca -config openssl.cnf  -days 3650 -in ../client/req.pem -out ../client/cert.pem -notext -batch -extensions client_extensions
# 这个 OpenSSL 命令用于通过证书颁发机构(CA)对先前生成的证书签发请求(CSR)进行签发，从而生成一个证书。让我解释一下每个参数的作用：

# - `openssl ca`: 这是 OpenSSL 工具的主命令，用于执行证书签发和管理操作。

# - `-config openssl.cnf`: 这个选项指定使用名为 "openssl.cnf" 的配置文件来配置证书签发操作。该配置文件包含了一些证书颁发过程所需的设置。

# - `-days 3650`: 这个选项指定生成的证书的有效期为 3650 天, 即10年。

# - `-in ../client/req.pem`: 这个选项指定输入的证书签发请求的路径和文件名。在这个例子中，输入的请求是位于 "../client/req.pem" 文件中的请求。

# - `-out ../client/cert.pem`: 这个选项指定生成的证书的输出路径和文件名。生成的证书将保存在 "../client/cert.pem" 文件中。

# - `-notext`: 这个选项指示 OpenSSL 在生成证书时不包含文本描述信息。

# - `-batch`: 这个选项启用批处理模式，意味着 OpenSSL 将不会提示用户进行任何交互操作，而是使用预定义的设置进行签发。

# - `-extensions client_extensions`: 这个选项指定在签发证书时使用的扩展配置。扩展配置可以包含一些附加的证书属性和约束。

# 综上所述，这个命令将使用指定的配置文件和参数，对输入的证书签发请求 "req.pem" 进行签发，生成一个证书并将其保存在 "../client/cert.pem" 文件中。签发过程将使用预定义的设置和扩展配置进行，且在批处理模式下完成，无需人工干预。

##################################################################################

# openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem -passout pass:bunnies
# 这个 OpenSSL 命令用于将证书和私钥打包到一个 PKCS#12 格式的文件中，通常以 .p12 或 .pfx 扩展名结尾。PKCS#12 是一种常用的文件格式，用于存储证书、私钥和可能的附加信息，以便在安全地传输和存储时使用。让我解释一下每个参数的作用：

# - `openssl pkcs12`: 这个命令用于操作 PKCS#12 格式的文件，包括创建、查看、导出等操作。

# - `-export`: 这个选项指示 OpenSSL 执行导出操作，将证书和私钥打包到 PKCS#12 文件中。

# - `-out keycert.p12`: 这个选项指定生成的 PKCS#12 文件的输出路径和文件名。生成的文件将保存在名为 "keycert.p12" 的文件中。

# - `-in cert.pem`: 这个选项指定要包含在 PKCS#12 文件中的证书文件的路径和文件名。在这个例子中，要包含的证书是 "cert.pem"。

# - `-inkey key.pem`: 这个选项指定要包含在 PKCS#12 文件中的私钥文件的路径和文件名。在这个例子中，要包含的私钥是 "key.pem"。

# - `-passout pass:bunnies`: 这个选项指定生成的 PKCS#12 文件的密码。在这个例子中，密码被设置为 "bunnies"。请注意，这是一个简单示例，请务必在实际使用中使用更强大的密码。

# 综上所述，这个命令将在一个 PKCS#12 文件中打包指定的证书文件 "cert.pem" 和私钥文件 "key.pem"，并设置文件密码为 "bunnies"。生成的 PKCS#12 文件将保存在 "keycert.p12" 文件中，可以用于在安全传输和存储时一并包含证书和私钥。

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

##################################################################################

# mkdir ./testca
# cp openssl.cnf ./testca/openssl.cnf
# cd ./testca
# mkdir certs private
# chmod 700 private
# echo 01 > serial
# touch index.txt
# openssl req -x509 -days 3650 -config openssl.cnf -newkey rsa:4096 -out cacert.pem -outform PEM -subj /CN=MyTestRootCA/L=$$/ -nodes
# openssl x509 -in cacert.pem -out cacert.cer -outform DER

# $ pwd
# /Users/huzhi/work/code/go_code/rabbitmq/tls-gen/01-basic/testca
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
# $

##################################################################################

# openssl req -x509 -days 3650 -config openssl.cnf -newkey rsa:4096 -out cacert.pem -outform PEM -subj /CN=MyTestRootCA/L=$$/ -nodes
# 这个 OpenSSL 命令用于生成自签名的根证书(Root CA Certificate)。让我解释一下每个参数的作用：

# - `openssl req`: 这是 OpenSSL 工具的主命令，用于处理证书签发请求和相关操作。

# - `-x509`: 这个选项指示 OpenSSL 生成自签名的 X.509 格式证书，而不是处理证书签发请求。

# - `-days 3650`: 这个选项指定证书的有效期为 3650 天, 即10年。

# - `-config openssl.cnf`: 这个选项指定使用名为 "openssl.cnf" 的配置文件来配置证书生成过程。该配置文件包含了一些生成证书所需的设置。

# - `-newkey rsa:4096`: 这个选项生成一个新的 RSA 私钥，长度为 4096 位。

# - `-out cacert.pem`: 这个选项指定生成的证书文件的输出路径和文件名。在这个例子中，生成的根证书将保存在名为 "cacert.pem" 的文件中。

# - `-outform PEM`: 这个选项指定输出的证书格式为 PEM 格式，它是一种常见的文本格式用于表示证书和私钥。

# - `-subj /CN=MyTestRootCA/L=$$/`: 这个选项设置证书的主题字段(Subject)。在这个例子中，根证书的主题设置为 Common Name (CN) 为 "MyTestRootCA", Location (L) 字段为空。

# - `-nodes`: 这个选项指示 OpenSSL 在生成私钥时不加密它。这意味着私钥将不使用密码进行保护。

# 综上所述，这个命令将使用指定的配置文件和参数生成一个包含自签名根证书的 PEM 格式文件 "cacert.pem", 该根证书在10年内有效 ,可以用于建立一个自己的根证书颁发机构(CA)。

##################################################################################

# openssl x509 -in cacert.pem -out cacert.cer -outform DER
# 这个 OpenSSL 命令用于将之前生成的 PEM 格式的根证书文件(cacert.pem)转换为 DER 格式的证书文件(cacert.cer)。让我解释一下每个参数的作用：

# - `openssl x509`: 这个命令用于操作 X.509 格式的证书，包括查看、转换和验证等操作。

# - `-in cacert.pem`: 这个选项指定输入的证书文件路径和文件名。在这个例子中，输入的证书是之前生成的 PEM 格式根证书文件 "cacert.pem"。

# - `-out cacert.cer`: 这个选项指定输出的证书文件路径和文件名。生成的 DER 格式证书将保存在名为 "cacert.cer" 的文件中。

# - `-outform DER`: 这个选项指定输出的证书格式为 DER 格式，它是一种二进制格式用于表示证书和相关数据。

# 综上所述，这个命令将从之前生成的 PEM 格式根证书文件 "cacert.pem" 中提取证书信息，并将其转换为 DER 格式，然后将转换后的 DER 格式证书保存在 "cacert.cer" 文件中。

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

print:
	@echo "OPENSSL: "${OPENSSL}
	@echo "DIR: "${DIR}
	@echo "CN: "${CN}
	@echo "P12PASS: "${P12PASS}
	@echo "NUMBER_OF_PRIVATE_KEY_BITS: "${NUMBER_OF_PRIVATE_KEY_BITS}
	@echo "DAYS_OF_VALIDITY: "${DAYS_OF_VALIDITY}
	@echo "CA_CERT_LOCATION: "${CA_CERT_LOCATION}
	@echo "CLIENT_CERT_LOCATION: "${CLIENT_CERT_LOCATION}
	@echo "SERVER_CERT_LOCATION: "${SERVER_CERT_LOCATION}

# $ PASSWORD=bunnies make print
# OPENSSL: openssl
# DIR: .
# CN: localhost
# P12PASS: true
# NUMBER_OF_PRIVATE_KEY_BITS: 4096
# DAYS_OF_VALIDITY: 3650
# CA_CERT_LOCATION: result/ca_certificate.pem
# CLIENT_CERT_LOCATION: result/client_certificate.pem
# SERVER_CERT_LOCATION: result/server_certificate.pem
