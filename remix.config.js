/** @type {import("@remix-run/dev").AppConfig} */
const localConfig = {
  ignoredRouteFiles: ['**/.*'],
  appDirectory: 'app',
  cacheDirectory: './node_modules/.cache/remix',
};

/** @type {import("@remix-run/dev").AppConfig} */
const awsConfig = {
  ...localConfig,
  assetsBuildDirectory: 'public/static',
  publicPath: '/static/',
  server: './server.ts',
  serverBuildDirectory: './server/build',
  serverBuildTarget: 'arc',
  serverDependenciesToBundle: [/^(?!aws).*/],
};

const isLocal = false;

module.exports = isLocal ? localConfig : awsConfig;
