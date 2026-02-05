import puppeteer from "puppeteer";

/**
 * Advanced Puppeteer Examples
 * Uncomment and modify these for different use cases
 */

// EXAMPLE 1: Login Flow
async function exampleLogin(page) {
  // Navigate to login page
  await page.goto("https://example.com/login");
  
  // Fill form
  await page.type('input[name="email"]', "user@example.com");
  await page.type('input[name="password"]', "password123");
  
  // Submit
  await page.click('button[type="submit"]');
  
  // Wait for redirect
  await page.waitForNavigation({ waitUntil: "networkidle2" });
}

// EXAMPLE 2: Click and Wait
async function exampleClickAndWait(page) {
  await page.goto("https://example.com");
  
  // Click button and wait for navigation
  await Promise.all([
    page.waitForNavigation({ waitUntil: "networkidle2" }),
    page.click("a#next-page")
  ]);
}

// EXAMPLE 3: Extract Data Table
async function exampleExtractTable(page) {
  await page.goto("https://example.com/data");
  
  const tableData = await page.evaluate(() => {
    const rows = document.querySelectorAll("table tr");
    return Array.from(rows).map(row => {
      const cells = row.querySelectorAll("td");
      return Array.from(cells).map(cell => cell.textContent);
    });
  });
  
  console.log("Table data:", tableData);
  return tableData;
}

// EXAMPLE 4: Scroll Page
async function exampleScroll(page) {
  await page.goto("https://example.com");
  
  // Scroll to bottom
  await page.evaluate(() => {
    window.scrollBy(0, window.innerHeight);
  });
  
  // Wait for lazy-loaded content
  await page.waitForTimeout(1000);