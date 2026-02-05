import puppeteer from "puppeteer";

(async () => {
  console.log("🚀 Starting browser automation");

  try {
    const browser = await puppeteer.launch({
      headless: true,
      args: [
        "--no-sandbox",
        "--disable-setuid-sandbox",
        "--disable-dev-shm-usage"
      ]
    });

    console.log("✅ Browser launched");

    const page = await browser.newPage();
    console.log("✅ New page created");

    // Navigate to a website
    console.log("📄 Navigating to https://example.com");
    await page.goto("https://example.com", { waitUntil: "networkidle2" });

    // Get page title
    const title = await page.title();
    console.log(`📋 Page title: ${title}`);

    // Get page URL
    const url = page.url();
    console.log(`🔗 Page URL: ${url}`);

    // Get all h1 tags
    const h1s = await page.evaluate(() => {
      return Array.from(document.querySelectorAll("h1")).map(el => el.textContent);
    });
    console.log(`📝 H1 tags found: ${h1s.join(", ")}`);

    // Get all links
    const links = await page.evaluate(() => {
      return Array.from(document.querySelectorAll("a")).map(el => ({
        text: el.textContent,
        href: el.href
      })).slice(0, 5); // First 5 links
    });
    console.log(`🔗 First 5 links:`);
    links.forEach((link, i) => {
      console.log(`   ${i + 1}. ${link.text} -> ${link.href}`);
    });

    // Take a screenshot
    console.log("📸 Taking screenshot...");
    await page.screenshot({ path: "screenshot.png" });
    console.log("✅ Screenshot saved as screenshot.png");

    // Close browser
    await browser.close();
    console.log("🛑 Browser closed");

    console.log("✨ Automation finished successfully!");
    process.exit(0);

  } catch (error) {
    console.error("❌ Error during automation:", error);
    process.exit(1);
  }
})();
