## config

* https://www.openssl.org/docs/man1.1.1/man5/config.html

### NAME

config - OpenSSL CONF library configuration files

### DESCRIPTION

The OpenSSL CONF library can be used to read configuration files. It is used for the OpenSSL master configuration file **openssl.cnf** and in a few other places like **SPKAC** files and certificate extension files for the **x509** utility. OpenSSL applications can also use the CONF library for their own purposes.
OpenSSL CONF 库可用于读取配置文件。 它用于 OpenSSL 主配置文件 openssl.cnf 以及其他一些地方，例如 x509 实用程序的 SPKAC 文件和证书扩展文件。 OpenSSL 应用程序还可以将 CONF 库用于自己的目的。

A configuration file is divided into a number of sections. Each section starts with a line **[ section_name ]** and ends when a new section is started or end of file is reached. A section name can consist of alphanumeric characters and underscores.
配置文件分为多个部分。 每个节都以行 [section_name] 开始，并在新节开始或到达文件末尾时结束。 节名称可以由字母数字字符和下划线组成。

The first section of a configuration file is special and is referred to as the **default** section. This section is usually unnamed and spans from the start of file until the first named section. When a name is being looked up it is first looked up in a named section (if any) and then the default section.
配置文件的第一部分很特殊，称为默认部分。 该部分通常是未命名的，并且从文件的开头到第一个命名的部分。 当查找名称时，首先在命名部分（如果有）中查找，然后在默认部分中查找。

The environment is mapped onto a section called **ENV**.
环境被映射到称为 ENV 的部分。

Comments can be included by preceding them with the **#** character
可以通过在注释前添加 # 字符来包含注释

Other files can be included using the **.include** directive followed by a path. If the path points to a directory all files with names ending with **.cnf** or **.conf** are included from the directory. Recursive inclusion of directories from files in such directory is not supported. That means the files in the included directory can also contain **.include** directives but only inclusion of regular files is supported there. The inclusion of directories is not supported on systems without POSIX IO support.
可以使用 .include 指令后跟路径来包含其他文件。 如果路径指向目录，则该目录中包含名称以 .cnf 或 .conf 结尾的所有文件。 不支持从此类目录中的文件递归包含目录。 这意味着包含目录中的文件也可以包含 .include 指令，但仅支持包含常规文件。 不支持 POSIX IO 的系统不支持包含目录。

It is strongly recommended to use absolute paths with the **.include** directive. Relative paths are evaluated based on the application current working directory so unless the configuration file containing the **.include** directive is application specific the inclusion will not work as expected.
强烈建议将绝对路径与 .include 指令一起使用。 相对路径是根据应用程序当前工作目录进行评估的，因此除非包含 .include 指令的配置文件是特定于应用程序的，否则包含将无法按预期工作。

There can be optional **=** character and whitespace characters between **.include** directive and the path which can be useful in cases the configuration file needs to be loaded by old OpenSSL versions which do not support the **.include** syntax. They would bail out with error if the **=** character is not present but with it they just ignore the include.
.include 指令和路径之间可以有可选的 = 字符和空格字符，这在配置文件需要由不支持 .include 语法的旧 OpenSSL 版本加载的情况下非常有用。 如果 = 字符不存在，他们会错误地退出，但是有了 = 字符，他们就会忽略包含。

Each section in a configuration file consists of a number of name and value pairs of the form **name=value**
配置文件中的每个部分都包含许多名称和值对，其形式为 name=value

The **name** string can contain any alphanumeric characters as well as a few punctuation symbols such as **.** **,** **;** and **_**.
名称字符串可以包含任何字母数字字符以及一些标点符号，例如 。 , ; 和 _。

The **value** string consists of the string following the **=** character until end of line with any leading and trailing white space removed.
值字符串由 = 字符后面的字符串组成，直到行尾，并删除了所有前导和尾随空格。

The value string undergoes variable expansion. This can be done by including the form **$var** or **${var}**: this will substitute the value of the named variable in the current section. It is also possible to substitute a value from another section using the syntax **$section::name** or **${section::name}**. By using the form **$ENV::name** environment variables can be substituted. It is also possible to assign values to environment variables by using the name **ENV::name**, this will work if the program looks up environment variables using the **CONF** library instead of calling getenv() directly. The value string must not exceed 64k in length after variable expansion. Otherwise an error will occur.
值字符串进行变量扩展。 这可以通过包含 $var 或 ${var} 形式来完成：这将替换当前部分中指定变量的值。 还可以使用语法 $section::name 或 ${section::name} 替换另一个节中的值。 通过使用 $ENV::name 形式可以替换环境变量。 还可以使用名称 ENV::name 为环境变量赋值，如果程序使用 CONF 库查找环境变量而不是直接调用 getenv()，这将起作用。 变量扩展后值字符串的长度不得超过 64k。 否则会出现错误。

It is possible to escape certain characters by using any kind of quote or the **\** character. By making the last character of a line a **\** a **value** string can be spread across multiple lines. In addition the sequences **\n**, **\r**, **\b** and **\t** are recognized.
可以使用任何类型的引号或 \ 字符来转义某些字符。 通过将一行的最后一个字符设置为 \，值字符串可以分布在多行中。 此外，还可以识别序列 \n、\r、\b 和 \t。

All expansion and escape rules as described above that apply to **value** also apply to the path of the **.include** directive.
如上所述，适用于 value 的所有扩展和转义规则也适用于 .include 指令的路径。

### OPENSSL LIBRARY CONFIGURATION

Applications can automatically configure certain aspects of OpenSSL using the master OpenSSL configuration file, or optionally an alternative configuration file. The **openssl** utility includes this functionality: any sub command uses the master OpenSSL configuration file unless an option is used in the sub command to use an alternative configuration file.
应用程序可以使用主 OpenSSL 配置文件或可选的替代配置文件自动配置 OpenSSL 的某些方面。 openssl 实用程序包含此功能：任何子命令都使用主 OpenSSL 配置文件，除非在子命令中使用了选项来使用备用配置文件。

To enable library configuration the default section needs to contain an appropriate line which points to the main configuration section. The default name is **openssl_conf** which is used by the **openssl** utility. Other applications may use an alternative name such as **myapplication_conf**. All library configuration lines appear in the default section at the start of the configuration file.
要启用库配置，默认部分需要包含指向主配置部分的适当行。 默认名称是 openssl_conf，由 openssl 实用程序使用。 其他应用程序可能使用替代名称，例如 myapplication_conf。 所有库配置行都显示在配置文件开头的默认部分中。

The configuration section should consist of a set of name value pairs which contain specific module configuration information. The **name** represents the name of the *configuration module*. The meaning of the **value** is module specific: it may, for example, represent a further configuration section containing configuration module specific information. E.g.:
配置部分应由一组名称值对组成，其中包含特定的模块配置信息。 name 代表配置模块的名称。 该值的含义是特定于模块的：例如，它可以表示包含配置模块特定信息的进一步配置部分。 例如。：

```
 # This must be in the default section
 openssl_conf = openssl_init

 [openssl_init]

 oid_section = new_oids
 engines = engine_section

 [new_oids]

 ... new oids here ...

 [engine_section]

 ... engine stuff here ...
```

The features of each configuration module are described below.

#### ASN1 Object Configuration Module

This module has the name **oid_section**. The value of this variable points to a section containing name value pairs of OIDs: the name is the OID short and long name, the value is the numerical form of the OID. Although some of the **openssl** utility sub commands already have their own ASN1 OBJECT section functionality not all do. By using the ASN1 OBJECT configuration module **all** the **openssl** utility sub commands can see the new objects as well as any compliant applications. For example:

```
 [new_oids]

 some_new_oid = 1.2.3.4
 some_other_oid = 1.2.3.5
```

It is also possible to set the value to the long name followed by a comma and the numerical OID form. For example:

```
 shortName = some object long name, 1.2.3.4
```

#### Engine Configuration Module

This ENGINE configuration module has the name **engines**. The value of this variable points to a section containing further ENGINE configuration information.

The section pointed to by **engines** is a table of engine names (though see **engine_id** below) and further sections containing configuration information specific to each ENGINE.

Each ENGINE specific section is used to set default algorithms, load dynamic, perform initialization and send ctrls. The actual operation performed depends on the *command* name which is the name of the name value pair. The currently supported commands are listed below.

For example:

```
 [engine_section]

 # Configure ENGINE named "foo"
 foo = foo_section
 # Configure ENGINE named "bar"
 bar = bar_section

 [foo_section]
 ... foo ENGINE specific commands ...

 [bar_section]
 ... "bar" ENGINE specific commands ...
```

The command **engine_id** is used to give the ENGINE name. If used this command must be first. For example:

```
 [engine_section]
 # This would normally handle an ENGINE named "foo"
 foo = foo_section

 [foo_section]
 # Override default name and use "myfoo" instead.
 engine_id = myfoo
```

The command **dynamic_path** loads and adds an ENGINE from the given path. It is equivalent to sending the ctrls **SO_PATH** with the path argument followed by **LIST_ADD** with value 2 and **LOAD** to the dynamic ENGINE. If this is not the required behaviour then alternative ctrls can be sent directly to the dynamic ENGINE using ctrl commands.

The command **init** determines whether to initialize the ENGINE. If the value is **0** the ENGINE will not be initialized, if **1** and attempt it made to initialized the ENGINE immediately. If the **init** command is not present then an attempt will be made to initialize the ENGINE after all commands in its section have been processed.

The command **default_algorithms** sets the default algorithms an ENGINE will supply using the functions ENGINE_set_default_string().

If the name matches none of the above command names it is assumed to be a ctrl command which is sent to the ENGINE. The value of the command is the argument to the ctrl command. If the value is the string **EMPTY** then no value is sent to the command.

For example:

```
 [engine_section]

 # Configure ENGINE named "foo"
 foo = foo_section

 [foo_section]
 # Load engine from DSO
 dynamic_path = /some/path/fooengine.so
 # A foo specific ctrl.
 some_ctrl = some_value
 # Another ctrl that doesn't take a value.
 other_ctrl = EMPTY
 # Supply all default algorithms
 default_algorithms = ALL
```

#### EVP Configuration Module

This modules has the name **alg_section** which points to a section containing algorithm commands.

Currently the only algorithm command supported is **fips_mode** whose value can only be the boolean string **off**. If **fips_mode** is set to **on**, an error occurs as this library version is not FIPS capable.

#### SSL Configuration Module

This module has the name **ssl_conf** which points to a section containing SSL configurations.

Each line in the SSL configuration section contains the name of the configuration and the section containing it.

Each configuration section consists of command value pairs for **SSL_CONF**. Each pair will be passed to a **SSL_CTX** or **SSL** structure if it calls SSL_CTX_config() or SSL_config() with the appropriate configuration name.

Note: any characters before an initial dot in the configuration section are ignored so the same command can be used multiple times.

For example:

```
 ssl_conf = ssl_sect

 [ssl_sect]

 server = server_section

 [server_section]

 RSA.Certificate = server-rsa.pem
 ECDSA.Certificate = server-ecdsa.pem
 Ciphers = ALL:!RC4
```

The system default configuration with name **system_default** if present will be applied during any creation of the **SSL_CTX** structure.

Example of a configuration with the system default:

```
 ssl_conf = ssl_sect

 [ssl_sect]
 system_default = system_default_sect

 [system_default_sect]
 MinProtocol = TLSv1.2
 MinProtocol = DTLSv1.2
```

### NOTES

If a configuration file attempts to expand a variable that doesn't exist then an error is flagged and the file will not load. This can happen if an attempt is made to expand an environment variable that doesn't exist. For example in a previous version of OpenSSL the default OpenSSL master configuration file used the value of **HOME** which may not be defined on non Unix systems and would cause an error.

This can be worked around by including a **default** section to provide a default value: then if the environment lookup fails the default value will be used instead. For this to work properly the default value must be defined earlier in the configuration file than the expansion. See the **EXAMPLES** section for an example of how to do this.

If the same variable exists in the same section then all but the last value will be silently ignored. In certain circumstances such as with DNs the same field may occur multiple times. This is usually worked around by ignoring any characters before an initial **.** e.g.

```
 1.OU="My first OU"
 2.OU="My Second OU"
```

### EXAMPLES

Here is a sample configuration file using some of the features mentioned above.

```
 # This is the default section.

 HOME=/temp
 RANDFILE= ${ENV::HOME}/.rnd
 configdir=$ENV::HOME/config

 [ section_one ]

 # We are now in section one.

 # Quotes permit leading and trailing whitespace
 any = " any variable name "

 other = A string that can \
 cover several lines \
 by including \\ characters

 message = Hello World\n

 [ section_two ]

 greeting = $section_one::message
```

This next example shows how to expand environment variables safely.

Suppose you want a variable called **tmpfile** to refer to a temporary filename. The directory it is placed in can determined by the **TEMP** or **TMP** environment variables but they may not be set to any value at all. If you just include the environment variable names and the variable doesn't exist then this will cause an error when an attempt is made to load the configuration file. By making use of the default section both values can be looked up with **TEMP** taking priority and **/tmp** used if neither is defined:

```
 TMP=/tmp
 # The above value is used if TMP isn't in the environment
 TEMP=$ENV::TMP
 # The above value is used if TEMP isn't in the environment
 tmpfile=${ENV::TEMP}/tmp.filename
```

Simple OpenSSL library configuration example to enter FIPS mode:

```
 # Default appname: should match "appname" parameter (if any)
 # supplied to CONF_modules_load_file et al.
 openssl_conf = openssl_conf_section

 [openssl_conf_section]
 # Configuration module list
 alg_section = evp_sect

 [evp_sect]
 # Set to "yes" to enter FIPS mode if supported
 fips_mode = yes
```

Note: in the above example you will get an error in non FIPS capable versions of OpenSSL.

Simple OpenSSL library configuration to make TLS 1.2 and DTLS 1.2 the system-default minimum TLS and DTLS versions, respectively:

```
 # Toplevel section for openssl (including libssl)
 openssl_conf = default_conf_section

 [default_conf_section]
 # We only specify configuration for the "ssl module"
 ssl_conf = ssl_section

 [ssl_section]
 system_default = system_default_section

 [system_default_section]
 MinProtocol = TLSv1.2
 MinProtocol = DTLSv1.2
```

The minimum TLS protocol is applied to **SSL_CTX** objects that are TLS-based, and the minimum DTLS protocol to those are DTLS-based. The same applies also to maximum versions set with **MaxProtocol**.

More complex OpenSSL library configuration. Add OID and don't enter FIPS mode:

```
 # Default appname: should match "appname" parameter (if any)
 # supplied to CONF_modules_load_file et al.
 openssl_conf = openssl_conf_section

 [openssl_conf_section]
 # Configuration module list
 alg_section = evp_sect
 oid_section = new_oids

 [evp_sect]
 # This will have no effect as FIPS mode is off by default.
 # Set to "yes" to enter FIPS mode, if supported
 fips_mode = no

 [new_oids]
 # New OID, just short name
 newoid1 = 1.2.3.4.1
 # New OID shortname and long name
 newoid2 = New OID 2 long name, 1.2.3.4.2
```

The above examples can be used with any application supporting library configuration if "openssl_conf" is modified to match the appropriate "appname".

For example if the second sample file above is saved to "example.cnf" then the command line:

```
 OPENSSL_CONF=example.cnf openssl asn1parse -genstr OID:1.2.3.4.1
```

will output:

```
    0:d=0  hl=2 l=   4 prim: OBJECT            :newoid1
```

showing that the OID "newoid1" has been added as "1.2.3.4.1".

### ENVIRONMENT

**OPENSSL_CONF**

The path to the config file. Ignored in set-user-ID and set-group-ID programs.

**OPENSSL_ENGINES**

The path to the engines directory. Ignored in set-user-ID and set-group-ID programs.

### BUGS

Currently there is no way to include characters using the octal **\nnn** form. Strings are all null terminated so nulls cannot form part of the value.

The escaping isn't quite right: if you want to use sequences like **\n** you can't use any quote escaping on the same line.

Files are loaded in a single pass. This means that a variable expansion will only work if the variables referenced are defined earlier in the file.

### SEE ALSO

[x509(1)](https://www.openssl.org/docs/man1.1.1/man1/x509.html), [req(1)](https://www.openssl.org/docs/man1.1.1/man1/req.html), [ca(1)](https://www.openssl.org/docs/man1.1.1/man1/ca.html)

### COPYRIGHT

Copyright 2000-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the "License"). You may not use this file except in compliance with the License. You can obtain a copy in the file LICENSE in the source distribution or at [/source/license.html](https://www.openssl.org/source/license.html).

You are here: [Home](https://www.openssl.org/) : [Docs](https://www.openssl.org/docs) : [Manpages](https://www.openssl.org/docs/manpages.html) : [1.1.1](https://www.openssl.org/docs/man1.1.1/) : [man5](https://www.openssl.org/docs/man1.1.1/man5) : [config](https://www.openssl.org/docs/man1.1.1/man5/config.html)  
[Sitemap](https://www.openssl.org/sitemap.txt)










