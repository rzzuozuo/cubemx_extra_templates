[#ftl]
[#list configs as config]
[#assign data = config]
config_object:${config?size}
[#assign myHash = { "name": "mouse", "price": 50 }]
[#list myHash?values as v]
  ${v}
[/#list]
  ${c.name}
[/#list]