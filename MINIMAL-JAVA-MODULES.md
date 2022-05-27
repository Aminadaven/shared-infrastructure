## Modules to use with JLink to produce a custom JRE
These are the minimal Java modules needed to run every app:
 - java.base
 - java.sql
 - java.naming
 - java.desktop
 - java.management
 - java.security.jgss
 - java.instrument

JLink needs to get all of them in 1 line:
 java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument

There is apparently another required module for Spring Boot apps that uses Undertow 
(I'm not sure that Undertow is what requires this but with Tomcat it wasn't needed):
 - jdk.unsupported

You can also avoid the risk of not having a required module by getting all of them:
 - ALL-MODULE-PATH

Notice: it will raise the JRE size from around 50MB to around 90MB
