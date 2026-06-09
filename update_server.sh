#!/bin/bash

echo "🚀 Iniciando atualização da WhatsAPI..."

# 1. Atualizar Node.js para v20
echo "📦 Atualizando Node.js para versão 20..."
curl -fsSL https://nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verificar versão
NODE_VER=$(node -v)
echo "✅ Node.js atualizado para: $NODE_VER"

# 2. Instalar ferramentas globais necessárias
echo "🛠️ Instalando ferramentas globais..."
sudo npm install -g npm@latest
sudo npm install -g typescript ts-node pm2

# 3. Limpar e Instalar dependências do projeto
echo "🧹 Limpando node_modules antigos..."
rm -rf node_modules
rm -f package-lock.json # Para garantir que pegue as versões fixas do package.json

echo "📥 Instalando novas dependências..."
npm install

# 4. Gerar Build (TSC)
echo "🔨 Compilando TypeScript..."
npm run build

# 5. Reiniciar o serviço no PM2
echo "🔄 Reiniciando serviço no PM2..."
pm2 restart WhatsAPINodeJs || pm2 start npm --name WhatsAPINodeJs -- run "start:prod"

echo "✨ Tudo pronto! Verifique o status com: pm2 status"
pm2 status WhatsAPINodeJs

# minha instalação

#processo git - atualização do projeto no servidor
#p 1) Garantir que não existam conflitos locais
	git reset --hard origin/main
#p 2) Baixar os novos arquivos
	git pull
#p 3) Verificar se os arquivos chegaram
	cat package.json | grep baileys
#pDeve aparecer: "@whiskeysockets/baileys": "6.6.0".

git pull
------------------------------------------------------

Atualizar Node.js para v20
node -v

---------------------------------------------------------

Executar a instalação/atualização

sudo npm install -g npm@latest
rm -rf node modules
rm -f package-lock.json # Opcional - Para garantir que pegue as versões 
npm install
npm run-script build
pm2 start npm --name WhatsAPINodeJs -- run "start:prod"
