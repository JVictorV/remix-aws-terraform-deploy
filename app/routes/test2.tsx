import { json } from '@remix-run/node';

export const loader = () => {
  return json({
    title: 'baile do jaca no teste 2',
    now: new Date(),
    env: process.env.NODE_ENV,
  });
};

export default function Test2() {
  return <h1>Hello from test2</h1>;
}
