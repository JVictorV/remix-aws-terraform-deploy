import { json } from '@remix-run/node';
import { useLoaderData } from '@remix-run/react';

export const loader = () => {
  return json({ now: new Date(), env: process.env.NODE_ENV });
};

export default function Index() {
  const { now, env } = useLoaderData<typeof loader>();

  return (
    <div
      style={{
        fontFamily: 'system-ui, sans-serif',
        lineHeight: '1.4',
        fontSize: '24px',
      }}
    >
      <h1>Baile do jaca</h1>
      <span>ENV: {env}</span>
      <br />
      <span>Server Date: {now}</span>
    </div>
  );
}
