Package.describe({
  summary: "Server Functionality",
  version: "0.0.1"
});
Package.on_use(function (api, where) {
  api.versionsFrom("METEOR-CORE@0.9.0-atm");
  api.use([
    'bads:core-lib',    
    'bads:mongo-aggregation',
    'accounts-base',
    'accounts-password',
    'coffeescript',
  ]);
  api.add_files(['core-server.coffee', 'subscription.coffee'], 'server');
});

Package.on_test(function (api) {
  api.use("../packages/bads:core-server");
  api.add_files('core-server_tests.js', ['client', 'server']);
});
