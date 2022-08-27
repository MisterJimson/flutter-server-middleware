import { NextResponse } from "next/server";
import mapping from "../../seoMapping.json";

export default async function handler(req, res) {
  const urlFromParam = req.query.url;
  const url = new URL(urlFromParam);

  // If we get traffic from an unknown origin, redirect to the 404 page.
  if (!mapping[url.origin]) {
    return NextResponse.redirect(url.origin + "/404");
  }

  // If we get traffic from an origin that has a route mapping, process the content here.
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

    res.setHeader("flutter-seo", "true");
    return res.status(200).send(result);
  }

  // This shouldn't happen, may need to add an API key to prevent misuse.
  return res.status(500).send("No route mapping found in API call");
}
