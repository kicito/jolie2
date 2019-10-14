# Jolie2

This repository contains proposals and discussion on features and specification for new major release of Jolie, Jolie2.

## TOC

[Modular Development](#Modular-Development)

## Modular Development

This section contains description and specification of Module system in Jolie

### Motivation

Module system is not supported in the current version of Jolie. The current workaround adopting **separation of concern** principal in Jolie is either using ```include``` or explicitly declare an embedded service. The capability of using keyword ```include``` is limited, since behavior behind it is appending content of target file into host file, then combined source code from both file are parsed by Jolie. Secondly, using embedded service gives developer perspective of running an additional service on top of the embedder program which still has it's limitation on several aspects of code-reusability such as declaration of inputPort's location. The support of module system will allow high-level decomposition of Jolie program into pieces and recompose each pieces into more complex program.

### Module structure

Modules in Jolie are determined by directories. A directory name is also defined module's name. Given following snippet

``` jolie
import IConsole from Console
```

The Interpreter is expected to do the following

1. The module finder determine if it can find the directory named **Console** using certain strategy at several lookup path including build-in modules, user specified path.
2. The source code of module's code and it's meta property [meta](#Meta) is store in the memory waiting to be evaluate at ```embbed``` identifier thus, the configuration of module can be defined dynamically by the embedder(EmbeddedServiceLoader??).

As seen above the syntax on ```import``` identifier is following

``` BNF
ImportDeclaration ::= "import ExportedIdentifiers from ImportPath [as Identifier]"
ExportedIdentifiers ::= Identifier | "," ExportedIdentifiers
```

- ExportedIdentifiers are any exported identifier in module.
- Identifier is any valid identifier which will be used in qualified identifiers
- ImportPath is string literal (raw or interpreted)

### Meta

Meta properties of modules is essential for developing the module system. as in 2017 TC39, the committee of ECMAScript presented the motivation on including ```import.meta```[1] to module script within browser. This variable contain per-module metadata inside the module. Supplement module's meta properties has been adopted by other major programing language such as ```__dirname``` in NodeJS, ```crate``` prefix in Rust, and ```__path__``` attribute in Python. This variable helps developers and the interpreter such as path resolving, detection of execution on top level(program unit) or not(a library)

e.g.

``` jolie
    // modules/interfaces/AIface.ol
    export type AMesg : void{ // export as a Module's public identifier
        name: string
    }
    // modules/A.ol
    import AMesg from interfaces // module importer performs lookup at directory path from meta property
    import File // module importer performs lookup at build-in modules
    main{
        readFile@File( { .filename = meta.dirname + "some.json"} )( jsonResponse )
      // rest of code is omitted
    }

```

### Module's public identifier

In order to achieve the encapsulation of namespace and present feeling of writing Jolie. Introducing an additional identifier to denote accessibility of the client module is necessary. A couple reasons are following

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
