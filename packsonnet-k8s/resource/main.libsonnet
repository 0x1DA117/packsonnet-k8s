local getKindIndex(kind, order) =
  local indexes = std.find(kind, order);
  assert std.length(indexes) > 0 : std.format('Kind %s not found in order', kind);
  indexes[0];

{
  kindOrder: {
    default():: [
      'CustomResourceDefinition',
      'MutatingWebhookConfiguration',
      'ValidatingWebhookConfiguration',
      'ServiceAccount',
      'Role',
      'ClusterRole',
      'RoleBinding',
      'ClusterRoleBinding',
      'Secret',
      'Deployment',
      'Service',
    ],

    withKindsAtPosition(position, kinds, baseOrder):: std.flattenArrays([
      baseOrder[0:position:1],
      kinds,
      baseOrder[position::1],
    ]),

    withKindsAfter(after, kinds, baseOrder)::
      local order = std.uniq(baseOrder);
      local newKinds = if std.isString(kinds) then [kinds] else kinds;
      local index = getKindIndex(after, order) + 1;

      self.withKindsAtPosition(index, newKinds, baseOrder),

    withKindsBefore(after, kinds, baseOrder)::
      local order = std.uniq(baseOrder);
      local newKinds = if std.isString(kinds) then [kinds] else kinds;
      local index = getKindIndex(after, baseOrder);

      self.withKindsAtPosition(index, newKinds, order),
  },

  newKindBasedSortFunc(order=$.kindOrder.default()):: function(resources)
    std.flattenArrays(
      [
        std.filter(function(res) res.kind == kind, resources)
        for kind in order
      ]
    ),
}
