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