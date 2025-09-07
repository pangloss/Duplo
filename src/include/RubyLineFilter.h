#ifndef _RUBYLINEFILTER_H_
#define _RUBYLINEFILTER_H_

#include "ILineFilter.h"

/**
 * This line filter handles Ruby heredocs and preserves code structure
 * by filtering out heredoc content that shouldn't be considered for duplication.
 */
class RubyLineFilter : public ILineFilter {
    bool m_inHeredoc;
    std::string m_heredocDelimiter;

public:
    RubyLineFilter();
    std::string ProcessSourceLine(const std::string& line) override;

private:
    bool IsHeredocStart(const std::string& line, std::string& delimiter);
    bool IsHeredocEnd(const std::string& line);
};

#endif