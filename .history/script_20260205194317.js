import puppeteer from "puppeteer";
import cron from "cron";
import fs from "fs";

// Create logs directory if it doesn't exist
if (!fs.existsSync("./logs")) {
  fs.mkdirSync("./logs");
}

// Run the automation task
async function runAutomation() {
  const timestamp = new Date().toLocaleString();
  console.log(`\n[${timestamp}] Starting automation...`);

  try {
    const browser = await puppeteer.launch({
      headless: true,
      args: [
        "--no-sandbox",
        "--disable-setuid-sandbox",
        "--disable-dev-shm-usage"
      ]
    });

    console.log("✓ Browser launched");

    const page = await browser.newPage();
    console.log("✓ New page created");

    // Navigate to Google
    console.log("→ Navigating to https://google.com");
    await page.goto("https://google.com", { waitUntil: "networkidle2" });

    // Get page title
    const title = await page.title();
    console.log(`✓ Page title: ${title}`);

    // Get page URL
    const url = page.url();
    console.log(`✓ Page URL: ${url}`);

    // Get page content info
    const pageInfo = await page.evaluate(() => {
      const searchBox = document.querySelector('input[name="q"]');
      const footer = document.querySelector('footer');
      
      return {
        hasSearchBox: !!searchBox,
        footerText: footer ? footer.innerText.substring(0, 100) : "N/A"
      };
    });
    console.log(`✓ Has search box: ${pageInfo.hasSearchBox}`);
    console.log(`✓ Footer info: ${pageInfo.footerText.slice(0, 50)}...`);

    // Get all links on page
    const links = await page.evaluate(() => {
      return Array.from(document.querySelectorAll("a")).map(el => ({
        text: el.textContent.trim(),
        href: el.href
      })).filter(link => link.text.length > 0).slice(0, 5);
    });
    console.log(`✓ First 5 links:`);
    links.forEach((link, i) => {
      console.log(`   ${i + 1}. ${link.text} -> ${link.href}`);
    });

    // Take a screenshot
    console.log("→ Taking screenshot...");
    const filename = `screenshot_${new Date().getTime()}.png`;
    await page.screenshot({ path: filename });
    console.log(`✓ Screenshot saved as ${filename}`);

    // Close browser
    await browser.close();
    console.log("✓ Browser closed");

    console.log(`[${timestamp}] Automation finished successfully!\n`);

  } catch (error) {
    console.error(`[${timestamp}] Error during automation:`, error);
  }
}

// Get schedule from environment or use default (8 AM every day)
const scheduleTime = process.env.SCHEDULE_TIME || "0 8 * * *";
const runOnStartup = process.env.RUN_ON_STARTUP === "true";

console.log("═══════════════════════════════════════════");
console.log("   Docker Headless Browser Automation");
console.log("═══════════════════════════════════════════");
console.log(`[INFO] Schedule: ${scheduleTime}`);
console.log(`[INFO] Cron format: minute hour day month day-of-week`);
console.log(`[INFO] (Default: 0 8 * * * = Daily at 8:00 AM)`);
console.log("═══════════════════════════════════════════\n");

// Run on startup if configured
if (runOnStartup) {
  console.log("[*] RUN_ON_STARTUP enabled - running now...");
  await runAutomation();
}

// Schedule the automation task
const job = cron.schedule(scheduleTime, () => {
  runAutomation();
}, {
  scheduled: true,
  timezone: process.env.TIMEZONE || "UTC"
});

console.log("[INFO] Cron job scheduled. Container will keep running.");
console.log("[INFO] Press Ctrl+C to stop.\n");

