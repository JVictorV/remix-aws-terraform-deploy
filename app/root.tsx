import type { ErrorBoundaryComponent, MetaFunction } from '@remix-run/node';
import {
  Links,
  LiveReload,
  Meta,
  Outlet,
  Scripts,
  ScrollRestoration,
} from '@remix-run/react';
import type { ReactNode } from 'react';

export const meta: MetaFunction = () => ({
  charset: 'utf-8',
  title: 'New Remix App',
  viewport: 'width=device-width,initial-scale=1',
});

function AppShell({ children }: { children: ReactNode }) {
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
      <head>
        <title>Oh no!</title>
      </head>
      <div>
        <h1>Ihh caralho deu ruim</h1>
        <p>{error.message}</p>
        <p>The stack trace is:</p>
        <pre>{error.stack}</pre>
      </div>
    </AppShell>
  );
};
