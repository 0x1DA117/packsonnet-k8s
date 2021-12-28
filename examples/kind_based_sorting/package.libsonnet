local pk8s = import 'packsonnet-k8s/main.libsonnet';
local k = import 'github.com/jsonnet-libs/k8s-libsonnet/1.22/main.libsonnet';

local package = pk8s.package;
local core = k.core.v1;
local apps = k.apps.v1;

package.new(
  function(config) [
    core.secret.new('my-service-secret', {foo: 'bar'}),
    core.serviceAccount.new('my-service-account')
    + core.serviceAccount.withSecrets([
      'my-service-secret',
    ]),
    apps.deployment.new('my-service', containers=[
      core.container.new('hello', 'nginxdemos/hello:latest')
    ])
    + apps.deployment.spec.template.spec.withServiceAccountName(
      'my-service-account'
    ),
  ],
  sortFunc=pk8s.resource.newKindBasedSortFunc(),
  nameFunc=pk8s.file.newIndexedNameFunc(),
)
