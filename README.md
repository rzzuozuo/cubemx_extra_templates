# cubemx_extra_templates

cubemx的外部模板

## 文件生成规则

filename_h.ftl -> felename.h  
filename_c.ftl -> filename.c

## 代码生成规则

代码生成规则使用了 [FreeMaker](https://freemarker.apache.org/docs/dgui.html),它使用了 Template + data - model = output 的模型  

OUTPUT:

```C
/*
 * Author:Allen
 * Date:2020-12-26
*/
#include "stm32g4xx_hal.h"
```

TEMPLATE:

```c
/*
 *
 * Author:{author}
 * Date:{date}
 *
*/
[#if MCU == G4]
#include "stm32g4xx_hal.h"
[#elseif]
#include "stm32f4xx_hal.h"
[#else]
#include "stm32f1xx_hal.h"
[/#if]
```

DATA MODEL:

```MODEL
(root)
  |
  +- Autor = "Allen"
  |
  +- date = "2020-12-26"
  |
  +- F1 = 0
  |
  +- G4 = 1|

  +- F4 = 2
  |
  +- MCU = G4
```

## template

* `${...}`:FreeMarker将在输出中将其替换为大括号内表达式的实际值。它们被称为**插值**。

* **FTL标签**（用于FreeMarker模板语言标签）：FTL标签与HTML标签有点相似，但是它们是FreeMarker的说明，不会被打印到输出中。这些标签的名称以开头 #。（用户定义的FTL标签使用 @代替#，但它们是高级主题。）

* **注释**：注释与HTML注释相似，但由[#--和分隔 --]。与HTML注释不同，FTL注释不会进入输出（访问者的页面源中将不可见），因为FreeMarker会跳过它们。

任何非FTL标签，插值或注释的内容均视为静态文本，FreeMarker不会对其进行解释；它只是按原样打印到输出中。

[试写一个模板](https://try.freemarker.apache.org/)

### 一些基本指令

在这里，我们将看一些最常用的指令（[但还有更多](https://freemarker.apache.org/docs/ref_directives.html)）。

#### if指令

使用if指令，您可以有条件地跳过模板的一部分。例如，假设在第一个示例中，您想与其他用户打招呼的方式是不同的：

OUTPUT:

```C
/*
 * Author:Allen
 * Date:2020-12-26
*/
#include "stm32g4xx_hal.h"
```

TEMPLATE:

```c
/*
 * Author:{author}
 * Date:{date}
*/
[#if MCU == G4]
#include "stm32g4xx_hal.h"
[#elseif]
#include "stm32f4xx_hal.h"
[#else]
#include "stm32f1xx_hal.h"
[/#if]
```

DATA MODEL:

```MODEL
(root)
  |
  +- Autor = "Allen"
  |
  +- date = "2020-12-26"
  |
  +- F1 = 0
  |
  +- G4 = 1|

  +- F4 = 2
  |
  +- MCU = G4
```

### list 指令

```freemarker
[#list sequence as loopVariable]重复部分,sequence大小为0是此部分不存在[/#list].

[#list sequence]不重复[#item as loopVariable]重复部分,sequence大小为0是此部分不存在[/#item]不重复[/#list]
```

`[#seq]...(或者写成[#seq]...[/#seq])：`只有当后面还有元素的时候才生效

list也可以使用`[#else]`,当sequence为空时，执行[#else]到[/#list]部分

### include 指令

使用`[#include "feilsname"]`可以替换大段需要改变的文本。例如协议许可等

### built-ins

使用`?`可以对变量的对象执行内置的方法,如

`characters?upper_case`·:将字符串改为大写  
`characters?cap_first`:首字母大写  
`characters?length`:长度  
`items?size`:大小  

如果在`[#list ]和[/#list]`中间还可以使用：

* `val?index`:index
* `val?counter`:index+1
* `val?item_parity`:counter的奇偶
