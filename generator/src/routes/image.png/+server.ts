import puppeteer from 'puppeteer';

export async function GET() {
    /**
     * Reason why we need pass args: ['--no-sandbox'] is because we are might be running this in a docker container
     * https://stackoverflow.com/questions/59087200/google-chrome-failed-to-move-to-new-namespace
     */
    const browser = await puppeteer.launch({ args: ['--no-sandbox'] });
    const page = await browser.newPage();
    await page.setViewport({
      width: 1404,
      height: 1872,
      deviceScaleFactor: 1,
    });
    await page.goto('http://localhost:5173');
    const img = await page.screenshot({ path: 'output.png' });
    await browser.close();

    return new Response(img);
}
