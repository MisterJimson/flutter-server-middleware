import { NextResponse } from "next/server";
import mapping from "../seoMapping.json";

export default async function middleware(req) {
  const url = req.nextUrl.clone();

  if (!mapping[url.origin]) {
    return NextResponse.redirect(url.origin + "/404");
  }

  const externalUrl = `${mapping[url.origin].downstreamUrl}${url.pathname}`;

  const routeMapping = mapping[url.origin].routes.find(
    (e) => e.path === url.pathname
  );

  if (routeMapping) {
    const externalContent = await fetch(externalUrl);
    const externalContentString = await externalContent.text();

    const additionalHeadTags = routeMapping.headTags.reduce(
      (prev, curr) => prev + curr + "\n",
      "<head>\n"
    );

    const additionalBodyTags = routeMapping.bodyTags.reduce(
      (prev, curr) => prev + curr + "\n",
      "<body>\n"
    );

    let result = externalContentString.replace("<head>", additionalHeadTags);
    result = result.replace("<body>", additionalBodyTags);

    return new NextResponse(result, {
      headers: externalContent.headers,
    });
    // temporary solution
  } else if (url.pathname === "/sitemap.xml") {
    return NextResponse.next();
  } else {
    return NextResponse.rewrite(externalUrl);
  }
}
