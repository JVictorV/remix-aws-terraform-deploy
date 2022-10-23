/** @type {import("@remix-run/dev").AppConfig} */
const localConfig = {
  ignoredRouteFiles: ['**/.*'],
  appDirectory: 'app',
  cacheDirectory: './node_modules/.cache/remix',
  assetsBuildDirectory: 'public/static',
  publicPath: '/static/',
  serverBuildDirectory: './server/build',
};

/** @type {import("@remix-run/dev").AppConfig} */
const awsConfig = {
  ...localConfig,
  server: './server.ts',
  serverBuildTarget: 'arc',
  serverDependenciesToBundle: [/^(?!aws).*/],
};

const isLocal = process.env.LOCAL;

module.exports = isLocal ? localConfig : awsConfig;
