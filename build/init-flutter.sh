#!/bin/bash

# Verifica a plataforma (android ou ios) passada como argumento
if [ "$1" = "android" ]; then
  FLUTTER_CHANNEL="stable"
  FLUTTER_VERSION="3.3.0"
  FLUTTER_SDK_DIR="/usr/local/flutter"

  # Configura as variáveis de ambiente para o Flutter
  export PATH="$FLUTTER_SDK_DIR/bin:$PATH"
  export ANDROID_HOME="$FLUTTER_SDK_DIR"
  export PATH="/usr/local/bin:$PATH"

  # Remove a versão anterior do Flutter
  flutter --version
  flutter --version | grep -qF "$FLUTTER_VERSION"
  if [ $? -ne 0 ]; then
    echo "Removendo a versão anterior do Flutter..."
    flutter --version | awk -F " " '{print $1}' | xargs -I {} sh -c 'rm -rf /usr/local/{}'
    flutter --version
  fi

  # Atualiza a versão do Flutter
  flutter precache
  flutter channel $FLUTTER_CHANNEL
  flutter version $FLUTTER_VERSION
fi
