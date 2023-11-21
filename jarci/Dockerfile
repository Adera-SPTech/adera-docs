FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session openjdk-17-jre

COPY /out/artifacts/adera_scanner_jar/adera-scanner.jar .

ENTRYPOINT ["java", "-jar", "/adera-scanner.jar"]
