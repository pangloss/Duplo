#!/bin/bash

@test "Ruby basic duplication detection" {
    run ./build/duplo tests/Simple_Ruby/files.lst -
    [ "$status" -eq 1 ]
    [[ "${lines[0]}" =~ "Loading and hashing files ... 5 done." ]]
    [[ "${output}" =~ "tests/Simple_Ruby/basic_duplication.rb found: 2 block(s)" ]]
    [[ "${output}" =~ "tests/Simple_Ruby/blocks_and_methods.rb found: 1 block(s)" ]]
    [[ "${output}" =~ "tests/Simple_Ruby/comments_strings.rb found: 3 block(s)" ]]
    [[ "${output}" =~ "Total 6 duplicate block(s) found." ]]
}

@test "Ruby heredoc handling" {
    run ./build/duplo tests/Simple_Ruby/heredoc_only.lst -
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" =~ "Loading and hashing files ... 1 done." ]]
    [[ "${output}" =~ "nothing found" ]]
    [[ "${output}" =~ "Total 0 duplicate block(s) found" ]]
}

@test "Ruby Rails model filtering" {
    run ./build/duplo -ip tests/Simple_Ruby/rails_only.lst -
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" =~ "Loading and hashing files ... 1 done." ]]
    [[ "${output}" =~ "nothing found" ]]
    [[ "${output}" =~ "Lines of code: 14" ]]
}

@test "Ruby comment and regex handling" {
    run ./build/duplo tests/Simple_Ruby/comments_only.lst -
    [ "$status" -eq 1 ]
    [[ "${output}" =~ "pattern = /test#pattern/" ]]
    [[ "${output}" =~ "string with # hash inside" ]]
    [[ "${output}" =~ "Hello #" ]]
}