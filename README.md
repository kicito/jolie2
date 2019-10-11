# Jolie2

This repository contains proposals and discussion on features and specification for new major release of Jolie, Jolie2.

## TOC

[Modular Development](#Modular-Development)

## Modular Development

This section contains description and specification of Module system in Jolie

### Motivation

Module system is not supported in the current version of Jolie. The current workaround adopting **separation of concern** principal in Jolie is either using ```include``` or explicitly declare an embedded service. The capability of using keyword ```include``` is limited, since behavior behind it is appending content of target file into host file, then combined source code from both file are parsed by Jolie. Secondly, using embedded service gives developer perspective of running an additional service on top of the embedder program which still has it's limitation on several aspects of code-reusability such as declaration of inputPort's location. The support of module system will allow high-level decomposition of Jolie program into pieces and recompose each pieces into more complex program.

### Module structure

Modules in Jolie are determined by directories. A directory name is  module is name Given following snippet

``` jolie
import IConsole from Console
```

The Interpreter is expected to do the following

1. The module finder determine if it can find the named module using certain strategy it knows about, a lookup path .

### Questions and inputs

- since "name of the service must be the same as the name of the enclosing file" then ```import Console [from Console]``` can be omitted
- javascript separate reading input from console into other package [readline](https://nodejs.org/api/readline.html) 
