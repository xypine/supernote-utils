import puppeteer from 'puppeteer';
import { env } from '$env/dynamic/private';

function get_localhost_url() {
    const host = env.HOST || "localhost";
    const port = env.PORT || "5173";
    return `http://${host}:${port}`;
}

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
    const localhost = get_localhost_url();
    console.info("[/image.png]: Rendering page at", localhost);
    await page.goto(localhost);
    const img = await page.screenshot({ path: 'output.png' });
    await browser.close();

    return new Response(img);
}
