# Use a base image com o Android Studio instalado
FROM cirrusci/android-sdk:33

# Define o diretório de trabalho
WORKDIR /app

# Define a versão do Flutter 
ARG FLUTTER_VERSION=3.3.10

# Baixa e instala o Flutter
RUN curl -L -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter.tar.xz \
    && rm flutter.tar.xz

# Adiciona o Flutter ao PATH do sistema
ENV PATH="/app/flutter/bin:${PATH}"

# Cria o diretório /etc/udev/rules.d/
RUN mkdir -p /etc/udev/rules.d/

# Instala o pacote usbutils para o comando lsusb
RUN apt-get update && apt-get install -y usbutils

# Configure as permissões e acesso aos dispositivos USB
RUN echo 'SUBSYSTEM=="usb", MODE="0666"' > /etc/udev/rules.d/usb.rules

# Teste a detecção de dispositivos USB
RUN lsusb

# Configura o Flutter
RUN flutter doctor --android-licenses && flutter doctor

# Define a versão do Gradle (substitua "7.3.3" pela versão desejada)
ARG GRADLE_VERSION=7.3.3

# Baixa e instala o Gradle
RUN curl -L -o gradle.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    && unzip gradle.zip \
    && rm gradle.zip

# Adiciona o Gradle ao PATH do sistema
ENV PATH="/app/gradle-${GRADLE_VERSION}/bin:${PATH}"

RUN git config --global --add safe.directory /app/flutter
RUN flutter --version
VOLUME /app/app
