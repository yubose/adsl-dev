// templete 使用 Mock
let Mock = require('mockjs')
const fs = require('fs');
const YAML = require('json-to-pretty-yaml');
let path = require('path')
let data = Mock.mock({
    // 属性 list 的值是一个数组，其中含有 1 到 10 个元素
    'list|1000': [{
        // 属性 id 是一个自增数，起始值为 1，每次增 1
        'hashCode|+1': 1783127988978,
        "description|+1": 141243124121,
        "code|+1": "3"
    }]
})
const yamlData = YAML.stringify(data);
console.log(yamlData);
fs.writeFile('../testpage/Mock_en.yml', yamlData,(err)=>{
    console.log(err);
});