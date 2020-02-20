include "file.iol"
include "string_utils.iol"
include "console.iol"
include "runtime.iol"

execution { single }

constants {
    NEWLINE="\n",
    RE_INI_KEY_VAL = "^\\s*([\\w.-]+)\\s*=\\s*(.*)?\\s*$",
    RE_NEWLINES = "\\\\n",
    NEWLINES_MATCH = "\\n|\\r|\\r\\n"
}

interface DotEnvIface{
    RequestResponse: readEnv()(any)
}

init {
    toAbsolutePath@File( "." )( basePath )
    getFileSeparator@File( )( separator )

    filePath = basePath + separator + ".env"

    println@Console(filePath)()

    readFile@File({filename = filePath})( envContents )
    split@StringUtils( envContents{regex= NEWLINES_MATCH} )( envLines )
    obj = void
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


        }
    }

    foreach (envKey : obj){
        getenv@Runtime( envKey )( osVar )
        if (osVar instanceof string){
            obj[envKey] = osVar
        }
    }
}



inputPort ip{
    interface: DotEnvIface
}

main {
    readEnv()(res){
        res << obj
    }
}