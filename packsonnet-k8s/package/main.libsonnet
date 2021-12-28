local packsonnet = import 'github.com/0xIDANT/packsonnet/main.libsonnet';
local file = import '../file/main.libsonnet';

{
  new(
    resourceFunc,
    sortFunc=packsonnet.resource.defaultSortFunc,
    nameFunc=file.defaultNameFunc,
    contentFunc=file.defaultContentFunc,
    defaultConfig={}
  )::
    packsonnet.package.new(
      resourceFunc,
      sortFunc=sortFunc,
      nameFunc=nameFunc,
      contentFunc=contentFunc,
      defaultConfig=defaultConfig
    )
}
