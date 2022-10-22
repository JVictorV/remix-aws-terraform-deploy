/** @type {import("@remix-run/dev").AppConfig} */
const localConfig = {
  ignoredRouteFiles: ['**/.*'],
};

/** @type {import("@remix-run/dev").AppConfig} */
const awsConfig = {};

const isLocal = true;

module.exports = isLocal ? localConfig : awsConfig;
