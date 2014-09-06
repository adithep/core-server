Package.describe({
  summary: "Server Functionality",
  version: "0.0.1",
  name: "bads:core-server"
});
Package.on_use(function (api, where) {
  api.versionsFrom('METEOR@0.9.2-rc1');
  api.use([
    'bads:core-lib',
    'bads:mongo-aggregation',
    'accounts-base',
    'accounts-password',
    'coffeescript'
  ]);
  api.add_files([
    'core-server.coffee',
    'methods.coffee',
    'subscription.coffee'], 'server');
});

Package.on_test(function (api) {
  api.use("bads:core-server");
  api.add_files('core-server_tests.js', ['client', 'server']);
});
