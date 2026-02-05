FROM ghcr.io/puppeteer/puppeteer:22

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies with npm ci for better Docker support
RUN npm ci --omit=dev || npm install --legacy-peer-deps

# Copy application code
COPY . .

# Run the automation script
CMD ["node", "script.js"]
