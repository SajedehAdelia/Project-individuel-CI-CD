# Utilise une image officielle de Node.js
FROM node:18

# Dossier de travail dans le conteneur
WORKDIR /app

# Copie les fichiers package.json et package-lock.json
COPY package*.json ./

# Installe les dépendances
RUN npm install

# Copie le reste du code
COPY . .

# Expose le port (à adapter si nécessaire)
EXPOSE 8080

# Lance l'application
CMD ["npm", "start"]
