import { json } from '@remix-run/node';

export const loader = () => {
  return json({
    title: 'baile do jaca',
    now: new Date(),
    env: process.env.NODE_ENV,
  });
};
