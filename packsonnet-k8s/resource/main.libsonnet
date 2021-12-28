{
  local defaultKindOrder = [
    'CustomResourceDefinition',
    'ServiceAccount',
    'Role',
    'ClusteRrole',
    'RoleBinding',
    'ClusterRoleBinding',
    'Secret',
    'Deployment',
    'Service',
  ],

  newKindBasedSortFunc(order=defaultKindOrder):: function(resources)
    std.flattenArrays(
      [
        std.filter(function(res) res.kind == kind, resources)
        for kind in order
      ]
    ),
}
