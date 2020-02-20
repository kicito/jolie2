
// assume standard libary is imported 
// include "file.iol"
// include "string_utils.iol"
// include "console.iol"
// include "runtime.iol"

constants {
    NEWLINE="\n",
    RE_INI_KEY_VAL = "^\\s*([\\w.-]+)\\s*=\\s*(.*)?\\s*$",
    RE_NEWLINES = "\\\\n",
    NEWLINES_MATCH = "\\n|\\r|\\r\\n"
}


interface DotEnvIface{
    RequestResponse: readEnv()(any)
}


type DotEnvJolie2Param{
    i: inputPort{
        interfaces: DotEnvIface
    },
    file?: string,
    debug?: bool
}

decl service DotEnvJolie2(DotEnvJolie2Param p {  
    i: inputPort{                               // default value
        location: //...                         // default value
        protocol: //...                         // default value
        interfaces: DotEnvIface                 // default value
    },
    file: ".env",                               // default value
    debug: false                                // default value
    // these default value will be merged with client's parameter on embed
}){
    execution { single }

    inputPort ip(p.i)
    
    init {

        if (is_defined(p.file)){
            filePath = p.file
        } else {
            toAbsolutePath@File( "." )( basePath )
            getFileSeparator@File( )( separator )

            filePath = basePath + separator + ".env"
        }

        if (debug){
            println@Console("reading file '" + filePath + "'")()
        }

        readFile@File({filename = filePath})( envContents )
        split@StringUtils( envContents{regex= NEWLINES_MATCH} )( envLines )
        obj = void
        i = 0
        for ( envLine in envLines.result ){
            // println@Console(envLine + " " + i)()
            match@StringUtils( envLine{regex= RE_INI_KEY_VAL} )( keyVal )
            if (is_defined(keyVal.group) && keyVal.group != ""){
                key = keyVal.group[1]
                if (!is_defined(keyVal.group[2])){
                    val =  ""
                } else {
                    val = keyVal.group[2]
                }
                length@StringUtils( val )( endIndex )
                if (endIndex > 1){

                    substring@StringUtils( val{end=1, begin=0} )( firstChar )
                    substring@StringUtils( val{end=endIndex, begin=endIndex-1} )( lastChar )

                    isSingleQuoted = firstChar == "'" && lastChar == "'"
                    isDoubleQuoted = firstChar == "\"" && lastChar == "\""
                    // if single or double quoted, remove quotes
                    if ( isDoubleQuoted || isSingleQuoted ){
                        substring@StringUtils(val{end=endIndex-1, begin=1})(val)
                        // if double quoted, expand newlines
                        if ( isDoubleQuoted ){
                            replaceAll@StringUtils(val{regex=RE_NEWLINES,replacement=NEWLINE})(val)
                        }
                    }else{
                        trim@StringUtils(val)(val)
                    }

                    obj.(key) = val
                }

                i++
            }else{
                if (debug){
                    println@Console("did not match key and value when parsing line ${idx + 1}: " + envLine)()
                }
            }
        }

        foreach (envKey : obj){
            getenv@Runtime( envKey )( osVar )
            if (osVar instanceof string){
                obj[envKey] = osVar
                if (debug){
                    println@Console("\"" + envKey + "\" is already defined in \`environment\` and will not be overwritten")
                }
            }
        }
    }

    main{
        readEnv()(res){
            obj << res
        }
    }
}