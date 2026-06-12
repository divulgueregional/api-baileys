# WhatsApp API - Baileys

API REST para WhatsApp baseada na biblioteca [Baileys](https://github.com/WhiskeySockets/Baileys).

---

## Índice

1. [Requisitos](#requisitos)
2. [Instalação com Docker (Recomendado)](#instalação-com-docker-recomendado)
3. [Instalação Manual](#instalação-manual)
4. [Configuração](#configuração)
5. [Uso da API](#uso-da-api)
6. [Comandos PM2](#comandos-pm2)
7. [Informações da Versão](#informações-da-versão)
8. [Solução de Problemas](#solução-de-problemas)

---

## Requisitos

| Dependência | Versão Mínima |
|-------------|---------------|
| Node.js     | 20.0.0        |
| npm         | 10.0.0        |
| Docker      | 24.0+ (se usar Docker) |

### Versão do Baileys

- **Versão atual**: `7.0.0-rc13`
- **Arquivo de configuração**: `package.json` (linha 20)
- **Repositório**: [@whiskeysockets/baileys](https://github.com/WhiskeySockets/Baileys)

**Verificar versão instalada:**
```bash
npm list @whiskeysockets/baileys
```

---

## Instalação com Docker (Recomendado)

### 1. Clonar o repositório
```bash
git clone https://github.com/divulgueregional/api-baileys
cd api-baileys
```

### 2. Configurar variáveis de ambiente
```bash
cp .env.example .env
nano .env
```

### 3. Subir o container
```bash
docker-compose up -d --build
```

### 4. Verificar logs
```bash
docker logs -f api-baileys-api-baileys-1
```

### 5. Acessar a API
```
http://localhost:8000/v3/docs/
```

> **⚠️ Importante**: Certifique-se de que a porta 8000 está liberada no firewall do servidor para a API funcionar corretamente.

### Comandos Docker úteis
```bash
# Parar container
docker-compose down

# Reconstruir sem cache
docker-compose build --no-cache

# Ver logs em tempo real
docker logs -f api-baileys-api-baileys-1

# Reiniciar container
docker-compose restart
```

---

## Instalação Manual

### 1. Instalar Node.js 20

**Ubuntu/Debian:**
```bash
# Instalar NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Carregar NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Instalar Node.js 20
nvm install 20
nvm use 20

# Verificar versão
node -v   # Deve mostrar v20.x.x
npm -v    # Deve mostrar 10.x.x
```

**Windows:**
- Baixar instalador: https://nodejs.org/dist/v20.18.0/node-v20.18.0-x64.msi

### 2. Instalar Git
```bash
sudo apt-get update
sudo apt-get install git
git --version
```

### 3. Clonar o repositório
```bash
git clone https://github.com/divulgueregional/api-baileys
cd api-baileys
```

### 4. Instalar dependências globais
```bash
npm install -g typescript
npm install -g ts-node
npm install -g pm2
```

### 5. Configurar variáveis de ambiente
```bash
cp .env.example .env
nano .env
```

### 6. Instalar dependências do projeto
```bash
npm install
```

### 7. Compilar o projeto
```bash
npm run build
```

### 8. Iniciar com PM2
```bash
pm2 start npm --name WhatsAPINodeJs -- run "start:prod"
```

### 9. Verificar status
```bash
pm2 status
```

### 10. Acessar a API
```
http://localhost:8000/v3/docs/
```

> **⚠️ Importante**: Certifique-se de que a porta 8000 está liberada no firewall do servidor para a API funcionar corretamente.

---

## Configuração

### Arquivo `.env`

```env
# Pusher (opcional - para QR Code em tempo real)
PUSHER_APP_ID=""
PUSHER_KEY=""
PUSHER_SECRET=""
PUSHER_CLUSTER=""

# Webhook
WEBOOK_BASE_URL=""
WEBOOK_SSL_VERIFY="false"
DISABLE_WEBHOOK="false"

# Identificação do navegador (aparece no WhatsApp)
BROWSER_CLIENT="System"
BROWSER_NAME="Chrome"

# Portas
HTTP_PORT=8000
HTTPS_PORT=443
```

### Configurar Pusher (opcional)

1. Cadastre-se em https://dashboard.pusher.com/
2. Crie um novo app
3. Copie as credenciais para o `.env`

> **Nota**: Sem Pusher, a API usa polling para atualizar o QR Code automaticamente.

---

## Uso da API

### Endpoints principais

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | `/rest/instance/init?instance_key=NOME` | Criar nova instância |
| GET | `/rest/instance/qrcode/NOME` | Exibir QR Code (HTML) |
| GET | `/rest/instance/qrcode_base64/NOME` | Obter QR Code (Base64) |
| DELETE | `/rest/instance/delete/NOME` | Excluir instância |

### Exemplo: Criar instância e ler QR Code

1. **Criar instância:**
```bash
curl -X POST "http://localhost:8000/rest/instance/init?instance_key=minha_instancia"
```

2. **Abrir QR Code no navegador:**
```
http://localhost:8000/rest/instance/qrcode/minha_instancia
```

3. **Escanear o QR Code** com o WhatsApp do celular

### Swagger UI

Documentação interativa disponível em:
```
http://localhost:8000/v3/docs/
```

---

## Comandos PM2

### Gerenciamento básico
```bash
# Ver status de todos os processos
pm2 status

# Ver logs em tempo real
pm2 log

# Monitorar recursos
pm2 monit

# Reiniciar processo
pm2 restart WhatsAPINodeJs

# Reiniciar todos
pm2 restart all

# Parar processo
pm2 stop WhatsAPINodeJs

# Excluir processo
pm2 delete WhatsAPINodeJs
```

### Atualizar a API
```bash
pm2 stop WhatsAPINodeJs
git pull
npm install
npm run build
pm2 start WhatsAPINodeJs
```

### Atualização completa (rebuild)
```bash
pm2 kill
npm install
npm run build
pm2 start npm --name WhatsAPINodeJs -- run "start:prod"
```

### Salvar configuração PM2
```bash
pm2 save
pm2 startup
```

### Desinstalar PM2
```bash
pm2 unstartup
pm2 kill
npm remove pm2 -g
rm -rf ~/.pm2
```

---

## Informações da Versão

### Verificar versão do Baileys

**Via npm:**
```bash
npm list @whiskeysockets/baileys
```

**Via arquivo:**
```bash
cat node_modules/@whiskeysockets/baileys/package.json | grep version
```

**Arquivo de configuração:**
- `package.json` - linha 20: `"@whiskeysockets/baileys": "^7.0.0-rc13"`

### Estrutura do projeto

```
api-baileys/
├── src/
│   ├── controllers/
│   │   └── InstanceController.ts    # Endpoints da API
│   ├── services/
│   │   └── Instance.ts              # Lógica do WhatsApp/Baileys
│   ├── Server.ts                    # Configuração do servidor
│   └── index.ts                     # Ponto de entrada
├── views/
│   └── qrcode.ejs                   # Template do QR Code
├── instances_data/                  # Dados das sessões (criado automaticamente)
├── .env                             # Variáveis de ambiente
├── package.json                     # Dependências e scripts
├── Dockerfile                       # Configuração Docker
└── docker-compose.yml               # Orquestração Docker
```

---

## Atualização da API

### Atualização com Docker

#### 1. Atualizar o código
```bash
cd api-baileys
git pull
```

#### 2. Reconstruir e subir o container
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

#### 3. Verificar logs
```bash
docker logs -f api-baileys-api-baileys-1
```

#### 4. Limpar sistema Docker (opcional)
```bash
docker system prune -f
```

---

### Atualização Manual (PM2)

#### 1. Atualizar o código
```bash
cd api-baileys
git pull
```

#### 2. Recompilar o TypeScript
```bash
npm run build
```

#### 3. Reiniciar o PM2
```bash
pm2 restart WhatsAPINodeJs
```

#### 4. Verificar logs
```bash
pm2 log
```

#### 5. Limpar logs antigos (opcional)
```bash
pm2 flush WhatsAPINodeJs
```

#### 6. Após atualização do Baileys (importante)
Se após atualizar para Baileys 7.0 o webhook parar de funcionar, execute:
```bash
# Parar o serviço
pm2 stop WhatsAPINodeJs

# Limpar compilação antiga
rm -rf dist/

# Recompilar
npm run build

# Iniciar novamente
pm2 start WhatsAPINodeJs
```

Isso corrige erros como `TypeError: remoteJidFone.endsWith is not a function`.

---

## Solução de Problemas

### Erro: "crypto is not defined"
**Causa**: Versão do Node.js incompatível.  
**Solução**: Atualizar para Node.js 20+.

### Erro: "EADDRINUSE" (porta em uso)
**Causa**: Outra aplicação usando a mesma porta.  
**Solução**: 
```bash
# Verificar processo na porta
netstat -tulpn | grep :8000

# Ou mudar a porta no .env
HTTP_PORT=8001
```

### QR Code não aparece
1. Verifique se a instância foi criada corretamente
2. Exclua a instância e crie novamente:
```bash
curl -X DELETE "http://localhost:8000/rest/instance/delete/NOME"
curl -X POST "http://localhost:8000/rest/instance/init?instance_key=NOME"
```

### Erro de permissão no PM2
```bash
chmod +x ./node_modules/.bin/cross-env
```

### Limpar sessões antigas
```bash
# Excluir todas as sessões
rm -rf instances_data/*

# Manter apenas .gitkeep
touch instances_data/.gitkeep
```

### Status "sempre online"
Configuração em `src/services/Instance.ts`:
```typescript
this.socketConfig = {
  markOnlineOnConnect: false,  // false = não fica sempre online
  // ...
};
```

---

## Licença

Este projeto utiliza a biblioteca Baileys sob licença MIT.

**Aviso**: Esta API não é afiliada ao WhatsApp. Use de forma responsável e de acordo com os Termos de Serviço do WhatsApp.
