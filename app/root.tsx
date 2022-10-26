import type { ErrorBoundaryComponent, MetaFunction } from '@remix-run/node';
import {
  Links,
  LiveReload,
  Meta,
  Outlet,
  Scripts,
  ScrollRestoration,
  useCatch,
  useMatches,
} from '@remix-run/react';
import type { ReactNode } from 'react';

export const meta: MetaFunction = () => ({
  charset: 'utf-8',
  title: 'Remix deploy with terraform on aws',
  viewport: 'width=device-width,initial-scale=1',
  description: 'A Remix application',
});

function AppShell({ children }: { children: ReactNode }) {
  const matches = useMatches();

  console.log(matches);
  return (
    <html lang='en'>
      <head>
        <Meta />
        <Links />
      </head>
      <body
        style={{
          fontFamily: 'system-ui, sans-serif',
          lineHeight: '1.4',
          fontSize: '24px',
        }}
      >
        {children}
        <Scripts />
      </body>
    </html>
  );
}

export default function App() {
  return (
    <AppShell>
      <Outlet />
      <ScrollRestoration />
      <LiveReload />
    </AppShell>
  );
}

export const ErrorBoundary: ErrorBoundaryComponent = ({ error }) => {
  console.error(error);
  return (
    <AppShell>
      <div>
        <h1>Ihh caralho deu ruim</h1>
        <p>{error.message}</p>
        <p>The stack trace is:</p>
        <pre>{error.stack}</pre>
      </div>
    </AppShell>
  );
};

export const CatchBoundary = () => {
  const caught = useCatch();
  console.log({ data: caught.data });
  return (
    <AppShell>
      <h1>
        {caught.status} - {caught.statusText}
      </h1>
      <img src={`https://http.cat/${caught.status}`} />
    </AppShell>
  );
};
