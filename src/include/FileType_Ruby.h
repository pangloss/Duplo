#ifndef _FILETYPE_RUBY_H_
#define _FILETYPE_RUBY_H_

#include "FileTypeBase.h"

struct FileType_Ruby : public FileTypeBase {
    FileType_Ruby(bool ignorePrepStuff, unsigned minChars);

    ILineFilterPtr CreateLineFilter() const override;

    std::string GetCleanLine(const std::string& line) const override;

    bool IsPreprocessorDirective(const std::string& line) const override;
};

#endif