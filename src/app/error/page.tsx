/**
 * v0 by Vercel.
 * @see https://v0.dev/t/y71wwxpKfsO
 * Documentation: https://v0.dev/docs#integrating-generated-code-into-your-nextjs-app
 */

import { CircleX } from "lucide-react";
import Link from "next/link";

export default function ErrorPage() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-background">
      <div className="mx-auto w-full max-w-md space-y-6">
        <div className="flex flex-col items-center space-y-2">
          <CircleX className="h-10 w-10" />
          <h2 className="text-2xl font-bold">Oops! Something went wrong.</h2>
          <Link href="/login" className="text-blue-500 hover:underline font-bold">
            Go Back
          </Link>
        </div>
      </div>
    </div>
  );
}
