# Jolie2

This repository contains proposals and discussion on new major feature of Jolie, module system.

## TOC

[Current State of Jolie](#Current-State)
[Module Structure](#Module-structure)

## Current State

The current state of Jolie's programming language does not have module system. The current workaround adopting **separation of concern** in Jolie is either using ```include``` or explicitly declare an embedded service. The capability of using keyword ```include``` is limited, since behavior behind it is appending content of target file into host file, then combined source code from both files is parsed by Jolie. Secondly, using embedded service gives developer perspective of running an additional service on top of the embedder program which still has it's limitation on several aspects of code-reusability of certain identifier, such as types and variable. The support of module system will enhance Jolie's flexibility and decomposition of code and help developer build more complex programs by integrate smaller modules together.

## Module structure

This section will describe the structure of module system in Jolie starting with the current feature of Jolie, and specification of the new module system.

### import syntax

``` BNF
import_stmt ::= "import" import_clause from_clause

import_clause ::= namespace_import | import_list

namespace_import ::= * "as" import_binding

import_list ::= import_specifier | import_list , import_specifier
import_specifier ::= import_binding | identifier_name as import_binding

import_binding ::= binding_identifier

from_clause ::= "from" module_specifier

module_specifier ::= string_literal
```

**Example**

``` jolie
  import Console from "console" (import-1)
  import * as hs from "http_status" (import-2)
  import dateType, timeType from "date"
  import Rand from "rand"
  import iden_A from "serviceA/main.ol"
```

* ```identifier_name``` = **exported** identifier found in ```module_specifier```.
* ```binding_identifier``` = identifier name to be bind in local namespace.

### import Behavior

1. Jolie module loader resolves ```module_specifier``` which is either a build-in module (eg. console) or perform a path lookup in ```modules``` folder in root project directory, or user specific path.
2. Jolie module loader parse content in imported file, result in executable code(olParser.parse()?) stored in a Map data structure associate with module name.
3. Module's program is execute within its context(OOIT?).
4. Evaluated result is bound into ```binding_identifier``` for local namespace of module client.

**Note**:

* In step (1) if the module loader unable to resolve ```module_specifier```, the ```ImportError``` is raised.
* In step (2,3) if there is errors occurs during parsing, the parsing process is stop and returns the error.
* In step (4) import statement from ```import_specifier``` binds exported module identifier into local namespace. If it is followed by "as" the ```import_binding``` is used as local name for the module see (import-1). For ```namespace_import``` all exported identifiers are bound into ```import_binding``` in local namespace (import-2)

Modules in Jolie are determined by directories. A directory name is also defined module's name. Given following snippet

**Ref:** https://docs.python.org/2.0/ref/import.html

### Module's public identifier

In order to achieve the encapsulation of namespace or information hinding within module in Jolie. Introducing an additional identifier to denote accessibility of the client module is necessary. A couple reasons are following

1. It helps module's author restricts the modification on part of their modules.
2. It helps module's user determines accessible parameters on module
3. It helps IDE language extension produce meaningful suggestions to the users

note: Services's parameters  

``` jolie
   service Main ( params:MainParams ) {  }
```  

can be considered as a service constructor

### Questions and inputs

- since "name of the service must be the same as the name of the enclosing file" then ```import Console [from Console]``` can be omitted. What about [here](https://github.com/fmontesi/jolie2/blob/master/Main.ol#L11) in Main.ol
- javascript separate reading input from console into other package [readline](https://nodejs.org/api/readline.html)
- the behavior on importing same module multiple time, should it gets same instance? so this code works.
  ``` jolie
  // modules/A.ol
  import Logger
   service AService ( params:MainParams ) {  }
  // main.ol
  import Logger
   service Main ( params:MainParams ) {  }
  ```

  or use dependency injection? 
  
  ``` jolie
  // modules/A.ol
  import Logger
   service AService ( params:MainParams ) {  }
  // main.ol
  import Logger
   service Main ( params:MainParams ) { 
        embed AService { 
          params: {.log = Logger}
    	}
    }
  ```

- How to dealing with modules that using same port internally e.g.
  ``` jolie

  ```
There should be no problem if it is using ```local``` protocol. Introduce message queue? and Pub/Sub?


to ask: what is behavior of module comparing to current embed service, debuggin in vscode?

## Reference
1. [Python module system](https://docs.python.org/3/reference/import.html)
2. [NodeJS module system](https://nodejs.org/api/modules.html)
3. [Rust module system](https://doc.rust-lang.org/stable/edition-guide/rust-2018/module-system/index.html)
4. [tc39 import meta proposal](https://github.com/tc39/proposal-import-meta)
