FROM ghcr.io/puppeteer/puppeteer:22

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --no-audit --no-fund

# Copy application code
COPY . .

# Run the automation script
CMD ["node", "script.js"]
