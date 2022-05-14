import { NextResponse } from "next/server";

const flutterBaseUrl = "https://flutter-seo-example.vercel.app";

export default async function middleware(req) {
  const url = req.nextUrl.clone();
  const externalUrl = `${flutterBaseUrl}${url.pathname}`;

  // Need better way to determine if the request is the inital page load
  if (url.toString().endsWith("/")) {
    const externalContent = await fetch(externalUrl);
    const externalContentString = await externalContent.text();

    // Add SEO tags to the initial page load
    var result = externalContentString.replace(
      "<head>",
      '<head>\n<meta name="author" content="John Doe">'
    );

    return new NextResponse(result, {
      headers: externalContent.headers,
    });
  } else {
    return NextResponse.rewrite(externalUrl);
  }
}
