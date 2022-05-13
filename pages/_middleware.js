import { NextResponse } from "next/server";

export default async function middleware(req) {
  const url = req.nextUrl.clone();

  if (url.toString().endsWith("/")) {
    const externalUrl = `https://gallery.flutter.dev${url.pathname}`;
    const externalContent = await fetch(externalUrl);

    const externalContentString = await externalContent.text();

    var result = externalContentString.replace(
      "<head>",
      '<head>\n<meta name="author" content="John Doe">'
    );

    return new NextResponse(result, {
      headers: externalContent.headers,
    });
  } else {
    return NextResponse.rewrite(`https://gallery.flutter.dev${url.pathname}`);
  }
}
