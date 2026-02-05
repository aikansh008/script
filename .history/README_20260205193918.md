# 🚀 Headless Browser Automation Docker Setup

A lightweight, efficient Docker setup for headless browser automation using Puppeteer. Runs without GUI, perfect for servers and scheduled tasks.

## ✨ Features

- ✅ **Headless Automation** - No GUI overhead, pure automation
- ✅ **Docker Container** - Isolated, reproducible environment
- ✅ **Auto-Restart** - Container restarts on failure
- ✅ **Windows Task Scheduler** - Schedule automated runs
- ✅ **Lightweight** - Minimal resource footprint
- ✅ **Puppeteer Integration** - Full browser automation capabilities
- ✅ **File Persistence** - Screenshots and outputs saved locally
- ✅ **Easy Logging** - View container logs in real-time

## 📋 Prerequisites

- **Windows 10/11** with Docker Desktop
- **Docker Desktop** (latest version)
- **PowerShell** (for setup scripts)
- **2GB RAM minimum** (4GB recommended)

## 🚀 Quick Start

### Option 1: PowerShell Script (Recommended)

```powershell
.\start-automation.ps1
```

### Option 2: Batch Script Menu

```cmd
start.bat
```

### Option 3: Manual Docker

```bash
# Build
docker build -t browser-automation .

# Run
docker-compose up -d

# View logs
docker-compose logs -f
```

## 📝 Automation Script

Edit [script.js](script.js) to customize what the browser does:

```javascript
// Navigate to a website
await page.goto("https://example.com");

// Fill a form
await page.type('input[name="search"]', 'Hello World');
await page.click('button[type="submit"]');

// Wait for element
await page.waitForSelector('.results');

// Take screenshot
await page.screenshot({ path: "results.png" });

// Extract data
const data = await page.evaluate(() => {
  return document.querySelector('h1').innerText;
});
console.log('Result:', data);
```

## 📅 Schedule Automated Runs

Run as Administrator:

```powershell
.\schedule-task.ps1
```

Choose your schedule:
- Daily at specific time (default 9:00 AM)
- Every 6 hours
- Custom time

View tasks in Task Scheduler:
- Press `Win + R`
- Type `taskschd.msc`
- Find `BrowserAutomationDocker`

## 🛑 Stop the Container

```bash
docker-compose down
```

## 📊 View Logs

**Real-time:**
```bash
docker-compose logs -f
```

**Last 100 lines:**
```bash
docker-compose logs --tail=100
```

## 🔧 Troubleshooting

### Container won't build
```bash
# Clean and rebuild
docker rmi browser-automation
docker build -t browser-automation .
```

### Script runs too fast/slow
Add delays in `script.js`:
```javascript
await page.waitForTimeout(2000); // Wait 2 seconds
```

### Port conflicts
Edit `docker-compose.yml` (headless doesn't expose ports by default)

### View detailed errors
```bash
docker-compose logs -f
```

## 📂 File Structure

```
.
├── Dockerfile              # Docker configuration
├── docker-compose.yml      # Compose configuration
├── package.json            # Node.js dependencies
├── script.js               # Your automation script
├── start-automation.ps1    # PowerShell starter
├── start.bat               # Batch file menu
├── schedule-task.ps1       # Task Scheduler setup
└── outputs/                # Auto-created output dir
```

## 🐳 Docker Commands

```bash
# Build
docker build -t browser-automation .

# Start (-d for detached/background)
docker-compose up -d

# Stop
docker-compose down

# View containers
docker ps

# View logs
docker-compose logs -f

# Remove image
docker rmi browser-automation
```

## 💡 Tips

- Use environment variables in `docker-compose.yml` for configuration
- Screenshots are saved to your current directory
- Container runs until script completes
- Use `restart: on-failure` in compose for auto-recovery
- Keep logs accessible for debugging

## 📞 Resources

- [Docker Docs](https://docs.docker.com/)
- [Puppeteer Docs](https://pptr.dev/)
- [Node.js Docs](https://nodejs.org/docs/)

---

**Happy Automating! 🎉**
