#include "RubyLineFilter.h"
#include "Utils.h"

#include <regex>

RubyLineFilter::RubyLineFilter()
    : m_inHeredoc(false) {
}

std::string RubyLineFilter::ProcessSourceLine(const std::string& line) {
    std::string trimmedLine = StringUtil::Trim(line);
    
    // If we're currently in a heredoc, check for end
    if (m_inHeredoc) {
        if (IsHeredocEnd(trimmedLine)) {
            m_inHeredoc = false;
            m_heredocDelimiter.clear();
        }
        // Return empty line to skip heredoc content
        return "";
    }
    
    // Check for heredoc start
    std::string delimiter;
    if (IsHeredocStart(trimmedLine, delimiter)) {
        m_inHeredoc = true;
        m_heredocDelimiter = delimiter;
        // Return the line that starts the heredoc (assignment part)
        // but remove the heredoc declaration
        size_t heredocPos = line.find("<<");
        if (heredocPos != std::string::npos) {
            return line.substr(0, heredocPos);
        }
    }
    
    // Return the original line for normal processing
    return line;
}

bool RubyLineFilter::IsHeredocStart(const std::string& line, std::string& delimiter) {
    // Match patterns: <<WORD, <<-WORD, <<~WORD
    std::regex heredocPattern(R"(<<([~-]?)([A-Za-z_][A-Za-z0-9_]*))");
    std::smatch match;
    
    if (std::regex_search(line, match, heredocPattern)) {
        delimiter = match[2].str(); // Extract the delimiter (WORD part)
        return true;
    }
    
    return false;
}

bool RubyLineFilter::IsHeredocEnd(const std::string& line) {
    // The line should match the delimiter exactly (with possible indentation for <<- and <<~)
    std::string trimmed = StringUtil::Trim(line);
    return trimmed == m_heredocDelimiter;
}