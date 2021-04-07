--[[
    AUTHOR: Fivos Moutavelis (https://github.com/FivosM).
    LICENSE: CC0 1.0 Universal (https://creativecommons.org/publicdomain/zero/1.0/legalcode).
    Attribution is not required but always appreciated.
]]--

local ini = {}

function ini.load( filePath )
    local fileInfo = love.filesystem.getInfo( filePath )
    if fileInfo and fileInfo.type == "file" then
        local iniTable = {}
        local currentSection = "default"
        for line in love.filesystem.lines( filePath ) do
            -- Returns a string if the line is a comment
            local isComment = string.match( line, "^%s*;.*$")
            if line ~= "" and isComment == nil then
                -- Get section name (if section)
                local section = string.match( line, "%[%s*(.*)%s*%]" )
                if section ~= nil then
                    currentSection = section
                    iniTable[section] = {}
                else
                    -- Get variable name and value
                    local variableName, variableValue = string.match( line, "^%s*(.*[^%s])%s*=%s*(.*[^%s])%s*$" )
                    if variableName and variableValue then
                        iniTable[currentSection][variableName] = variableValue
                    end
                end
            end
        end
        return iniTable
    end
    return nil
end

function ini.save( iniTable, file )
    if iniTable then
        local writeString = ""
        for sectionName, sectionValue in pairs( iniTable ) do
            writeString = writeString .. "[" .. sectionName .. "]" .. "\r\n"
            for variableName, variableValue in pairs( sectionValue ) do
                writeString = writeString .. variableName .. " = " .. variableValue .. "\r\n"
            end
        end
        local success, message = love.filesystem.write( file, writeString )
        if not success then
            return message
        end
        return 1
    end
    return nil
end

function ini.readKey( iniTable, sectionName, keyName )
    return iniTable[sectionName][keyName]
end

function ini.addSection( iniTable, newSectionName )
    iniTable[newSectionName] = {}
    return 1
end

function ini.addKey( iniTable, sectionName, keyName, keyValue )
    iniTable[sectionName][keyName] = keyValue
    return 1
end

function ini.sectionExists( iniTable, sectionName )
    if iniTable[sectionName] then
        return 1
    end
    return 0
end

function ini.keyExists( iniTable, sectionName, keyName )
    if iniTable[sectionName][keyName] then
        return 1
    end
    return 0
end

function ini.deleteSection( iniTable, sectionName )
    iniTable[sectionName] = nil
    return 1
end

function ini.deleteKey( iniTable, sectionName, keyName )
    iniTable[sectionName][keyName] = nil
    return 1
end

return ini

