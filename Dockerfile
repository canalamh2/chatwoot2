# Usa a imagem oficial do node 14.x
FROM node:14

# Diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo package.json e package-lock.json para o contêiner
COPY package*.json ./

# Instala as dependências do Chatwoot
RUN npm install

# Copia os arquivos do Chatwoot para o contêiner
COPY . .

# Define as variáveis de ambiente necessárias para o Chatwoot
ENV RAILS_ENV=production \
    NODE_ENV=production \
    DATABASE_URL=postgresql://postgres:kBnHhwlhHv1GoOa7tUox@containers-us-west-18.railway.app:7809/railway \
    REDIS_URL=redis://redis:6379 \
    CHATWOOT_SECRET_KEY_BASE=my_secret_key_base

# Compila os assets do Chatwoot
RUN bundle exec rails assets:precompile

# Expõe a porta 3000
EXPOSE 3000

# Inicia o Chatwoot
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
