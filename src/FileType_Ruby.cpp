#include "FileType_Ruby.h"
#include "RubyLineFilter.h"
#include "Utils.h"

#include <cstring>

FileType_Ruby::FileType_Ruby(bool ignorePrepStuff, unsigned minChars)
    : FileTypeBase(ignorePrepStuff, minChars) {
}

ILineFilterPtr FileType_Ruby::CreateLineFilter() const {
    return std::make_shared<RubyLineFilter>();
}

std::string FileType_Ruby::GetCleanLine(const std::string& line) const {
    return RubyUtils::RemoveSingleLineComments(line);
}

bool FileType_Ruby::IsPreprocessorDirective(const std::string& line) const {
    // Handle shebang
    if (line.find("#!", 0, 2) != std::string::npos) {
        return true;
    }

    // Core Ruby language constructs
    const char* coreMarkers[] = { 
        "require", "require_relative", "load", "autoload",
        "module", "class", "def", "end",
        "attr_accessor", "attr_reader", "attr_writer",
        "alias", "alias_method",
        "private", "protected", "public",
        "include", "extend", "prepend"
    };

    for (auto marker : coreMarkers) {
        if (line.find(marker, 0, std::strlen(marker)) != std::string::npos) {
            return true;
        }
    }

    // Rails-specific constructs
    const char* railsMarkers[] = {
        "has_many", "has_one", "belongs_to", "has_and_belongs_to_many",
        "validates", "validate", "validates_presence_of", "validates_length_of",
        "validates_uniqueness_of", "validates_format_of", "validates_numericality_of",
        "before_action", "after_action", "around_action", "skip_before_action",
        "before_save", "after_save", "before_create", "after_create",
        "before_update", "after_update", "before_destroy", "after_destroy",
        "before_validation", "after_validation"
    };

    for (auto marker : railsMarkers) {
        if (line.find(marker, 0, std::strlen(marker)) != std::string::npos) {
            return true;
        }
    }

    return false;
}