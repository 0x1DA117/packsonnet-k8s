{
  local defaultKindOrder = [
    'CustomResourceDefinition',
    'ServiceAccount',
    'Role',
    'ClusterRole',
    'RoleBinding',
    'ClusterRoleBinding',
    'Secret',
    'Deployment',
    'Service',
  ],

  addToKindOrder(kinds, order=defaultKindOrder, after=null, before=null)::
    assert std.type(after) != 'null' && std.type(before) != 'null'
      : 'Only one of the arguments `after` and `before` can be set';

    local kinds = if std.isString(kinds) then [kinds] else kinds;
    local kindToFind = if std.type(after) != 'null' then after else before;
    local kindIndexes = std.find(kindToFind, order);

    assert std.length(kindIndexes) > 0 : std.format('Kind %s not found in order', kindToFind);

    local matchedIndex = kindIndexes[std.length(kindIndexes) - 1];
    local left = order[0:matchedIndex:1];
    local right = order[matchedIndex + 1:std.legth(order) - 1:1];

    std.flattenArrays([left,kinds,right]),

  newKindBasedSortFunc(order=defaultKindOrder):: function(resources)
    std.flattenArrays(
      [
        std.filter(function(res) res.kind == kind, resources)
        for kind in order
      ]
    ),
}
