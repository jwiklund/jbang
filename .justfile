open := if os() == "macos" { "open" } else { "xdg-open" }

#@default:
#    just --choose

# build without tests
build:
    ./gradlew spotlessApply installDist -x test

# run tests
test:
    ./gradlew test

preitest := if path_exists('build/install/jbang/bin') != 'true' {
  './gradlew installDist -x test'
} else {
    ''
}

# open test report 
opentest:
    {{open}} build/reports/tests/test/index.html

# run integration tests
itest:
    {{preitest}}
    @cd itests && ./itests.sh

# open integeration test report
openitest:
    {{open}} build/karate/surefire-reports/karate-summary.html

# tag minor
tagminor:
    git commit --allow-empty -m "[minor] relase"
    ./gradlew tag

tagpatch:
    git commit --allow-empty -m "[patch] relase"
    ./gradlew tag

