import { NextResponse } from "next/server";
import mapping from "./seoMapping.json";

export default async function middleware(req) {
  const url = req.nextUrl;

  // This prevents looping as the content is already processed by the API route.
  if (req.headers.get("flutter-seo") === "true") {
    return NextResponse.next();
  }

  // If we get traffic from an unknown origin, redirect to the 404 page.
  if (!mapping[url.origin]) {
    return NextResponse.redirect(url.origin + "/404");
  }

  // If we get traffic from an origin that has a route mapping, process the content in the API route.
  const externalUrl = `${mapping[url.origin].downstreamUrl}${url.pathname}`;
  const routeMapping = mapping[url.origin].routes.find(
    (e) => e.path === url.pathname
  );

  if (routeMapping) {
    return NextResponse.rewrite(
      `${process.env.SITE_URL}/api/modify-response?url=${url}`
    );
  }

  // If we get traffic from a a route without mapping, rewrite the external content.
  return NextResponse.rewrite(externalUrl);
}
