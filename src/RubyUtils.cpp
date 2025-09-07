#include "Utils.h"

std::string RubyUtils::RemoveSingleLineComments(const std::string& line) {
    std::string cleanedLine;
    cleanedLine.reserve(line.size());
    
    bool inSingleQuote = false;
    bool inDoubleQuote = false;
    bool inRegex = false;
    bool escaped = false;
    
    for (std::string::size_type i = 0; i < line.size(); i++) {
        char c = line[i];
        
        // Handle escape sequences
        if (escaped) {
            cleanedLine.push_back(c);
            escaped = false;
            continue;
        }
        
        if (c == '\\' && (inSingleQuote || inDoubleQuote || inRegex)) {
            escaped = true;
            cleanedLine.push_back(c);
            continue;
        }
        
        // Handle regex boundaries
        if (c == '/' && !inSingleQuote && !inDoubleQuote) {
            inRegex = !inRegex;
            cleanedLine.push_back(c);
            continue;
        }
        
        // Handle quote boundaries (only if not in regex)
        if (c == '\'' && !inDoubleQuote && !inRegex) {
            inSingleQuote = !inSingleQuote;
            cleanedLine.push_back(c);
            continue;
        }
        
        if (c == '"' && !inSingleQuote && !inRegex) {
            inDoubleQuote = !inDoubleQuote;
            cleanedLine.push_back(c);
            continue;
        }
        
        // If we find # outside of quotes and regex, truncate the line here
        if (c == '#' && !inSingleQuote && !inDoubleQuote && !inRegex) {
            break;
        }
        
        cleanedLine.push_back(c);
    }
    
    return cleanedLine;
}