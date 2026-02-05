// import puppeteer from "puppeteer";

// /**
//  * Advanced Puppeteer Examples
//  * Uncomment and modify these for different use cases
//  */

// // EXAMPLE 1: Login Flow
// async function exampleLogin(page) {
//   // Navigate to login page
//   await page.goto("https://example.com/login");
  
//   // Fill form
//   await page.type('input[name="email"]', "user@example.com");
//   await page.type('input[name="password"]', "password123");
  
//   // Submit
//   await page.click('button[type="submit"]');
  
//   // Wait for redirect
//   await page.waitForNavigation({ waitUntil: "networkidle2" });
// }

// // EXAMPLE 2: Click and Wait
// async function exampleClickAndWait(page) {
//   await page.goto("https://example.com");
  
//   // Click button and wait for navigation
//   await Promise.all([
//     page.waitForNavigation({ waitUntil: "networkidle2" }),
//     page.click("a#next-page")
//   ]);
// }

// // EXAMPLE 3: Extract Data Table
// async function exampleExtractTable(page) {
//   await page.goto("https://example.com/data");
  
//   const tableData = await page.evaluate(() => {
//     const rows = document.querySelectorAll("table tr");
//     return Array.from(rows).map(row => {
//       const cells = row.querySelectorAll("td");
//       return Array.from(cells).map(cell => cell.textContent);
//     });
//   });
  
//   console.log("Table data:", tableData);
//   return tableData;
// }

// // EXAMPLE 4: Scroll Page
// async function exampleScroll(page) {
//   await page.goto("https://example.com");
  
//   // Scroll to bottom
//   await page.evaluate(() => {
//     window.scrollBy(0, window.innerHeight);
//   });
  
//   // Wait for lazy-loaded content
//   await page.waitForTimeout(1000);
// }

// // EXAMPLE 5: Handle Multiple Pages
// async function exampleMultiplePages() {
//   const browser = await puppeteer.launch({
//     headless: true,
//     args: ["--no-sandbox", "--disable-setuid-sandbox"]
//   });
  
//   // Page 1
//   const page1 = await browser.newPage();
//   await page1.goto("https://example.com");
//   console.log("Page 1 title:", await page1.title());
  
//   // Page 2
//   const page2 = await browser.newPage();
//   await page2.goto("https://example.org");
//   console.log("Page 2 title:", await page2.title());
  
//   await page1.close();
//   await page2.close();
//   await browser.close();
// }

// // EXAMPLE 6: Handle Dialogs
// async function exampleDialogs(page) {
//   // Handle alert
//   page.on("dialog", async (dialog) => {
//     console.log("Dialog message:", dialog.message());
//     await dialog.accept();
//   });
  
//   await page.goto("https://example.com");
// }

// // EXAMPLE 7: Set User Agent
// async function exampleUserAgent(browser) {
//   const page = await browser.newPage();
  
//   await page.setUserAgent(
//     "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
//   );
  
//   await page.goto("https://example.com");
//   console.log("User agent set");
// }

// // EXAMPLE 8: Performance Metrics
// async function exampleMetrics(page) {
//   await page.goto("https://example.com");
  
//   const metrics = await page.metrics();
//   console.log("Load time:", metrics.navigationStart);
//   console.log("First paint:", metrics.firstPaint);
// }

// // EXAMPLE 9: Wait for Selector
// async function exampleWaitForSelector(page) {
//   await page.goto("https://example.com");
  
//   // Wait for element to appear
//   await page.waitForSelector(".dynamic-element", { timeout: 5000 });
//   console.log("Dynamic element appeared");
// }

// // EXAMPLE 10: Execute JavaScript
// async function exampleExecuteJS(page) {
//   await page.goto("https://example.com");
  
//   const result = await page.evaluate(() => {
//     return {
//       title: document.title,
//       url: window.location.href,
//       cookies: document.cookie
//     };
//   });
  
//   console.log("Result:", result);
// }

// export {
//   exampleLogin,
//   exampleClickAndWait,
//   exampleExtractTable,
//   exampleScroll,
//   exampleMultiplePages,
//   exampleDialogs,
//   exampleUserAgent,
//   exampleMetrics,
//   exampleWaitForSelector,
//   exampleExecuteJS
// };
