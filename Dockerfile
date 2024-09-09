# image
FROM node:14

# create a working directory
WORKDIR /app

# Copy package.json and package-lock.json to the WORKDIR
COPY package*.json ./

# Install app dep
RUN npm install

COPY . .

# Expose app port 
EXPOSE 3000

# Run app
CMD ["node", "index.js"]
