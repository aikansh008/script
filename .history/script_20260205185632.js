import puppeteer from "puppeteer";

(async () => {
  console.log("🚀 Starting browser automation");

  try {
    const browser = await puppeteer.launch({
      headless: process.env.HEADLESS !== 'false',
      args: [
        "--no-sandbox",
        "--disable-setuid-sandbox",
        "--disable-dev-shm-usage"
      ]
    });

    console.log("✅ Browser launched");

    const page = await browser.newPage();
    console.log("✅ New page created");

    // Navigate to Google
    console.log("📄 Navigating to https://google.com");
    await page.goto("https://google.com", { waitUntil: "networkidle2" });

    // Get page title
    const title = await page.title();
    console.log(`📋 Page title: ${title}`);

    // Get page URL
    const url = page.url();
    console.log(`🔗 Page URL: ${url}`);

    // Get page content info
    const pageInfo = await page.evaluate(() => {
      const searchBox = document.querySelector('input[name="q"]');
      const footer = document.querySelector('footer');
      
      return {
        hasSearchBox: !!searchBox,
        footerText: footer ? footer.innerText.substring(0, 100) : "N/A"
      };
    });
    console.log(`🔍 Has search box: ${pageInfo.hasSearchBox}`);
    console.log(`📝 Footer info: ${pageInfo.footerText.slice(0, 50)}...`);

    // Get all links on page
    const links = await page.evaluate(() => {
      return Array.from(document.querySelectorAll("a")).map(el => ({
        text: el.textContent.trim(),
        href: el.href
      })).filter(link => link.text.length > 0).slice(0, 5); // First 5 non-empty links
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
