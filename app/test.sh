#!/bin/sh

EXIT_CODE=0

rm -rf /app/coverage.log
rm -rf /app/.coverage
rm -rf /app/test.log

coverage erase
coverage run manage.py test &> test.log
coverage report 2>&1 | tee coverage.log

# Define colors
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\e[36m'
NC='\033[0m'

# Check if unit tests failed!
TEST_RESULT=$(cat test.log  | grep -o 'FAILED')
if [ $TEST_RESULT ]; then
    printf "${RED}ERROR:${NC} ${YELLOW}Test $TEST_RESULT!${NC}\n"
    printf "${BLUE}"
    cat test.log
    printf "${NC}"
    EXIT_CODE=1
fi

# Check if test coverage is high enough
EXPECTED_COVERAGE=$(coverage report | tail -n1 | cut -d"=" -f 2)
RETURNED_COVERAGE=$(coverage report | tail -n1 | cut -d' ' -f 5)
COVERAGE_RESULT=$(coverage report | tail -n1 | awk '{print $2}' | head -c 7)
if [ "$COVERAGE_RESULT" = "failure" ]; then
    printf "${RED}ERROR:${NC} ${YELLOW}Test coverage $RETURNED_COVERAGE is smaller than expected coverage ($EXPECTED_COVERAGE)${NC}\n"
    EXIT_CODE=1
fi

rm -rf /app/coverage.log
rm -rf /app/.coverage
rm -rf /app/test.log

exit $EXIT_CODE