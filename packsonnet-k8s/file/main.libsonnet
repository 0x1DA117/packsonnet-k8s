{
  defaultNameFunc(index, resource):: std.format(
    '%s_%s.json',
    [
      std.asciiLower(resource.kind),
      std.strReplace(
        std.strReplace(resource.metadata.name, ':', '_'),
        '-',
        '_'
      ),
    ]
  ),

  newIndexedNameFunc(format='%02d_%s', start=1)::
    function(index, resource)
      std.format(
        format,
        [
          index + start,
          self.defaultNameFunc(index, resource),
        ]
      ),

  defaultContentFunc(resource):: resource,
}
