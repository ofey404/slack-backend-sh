run: clean-cache
	test -s .env || { echo "no .env file"; exit 1; }
	./main.sh

clean: clean-cache
	rm -rf ./data

clean-cache:
	rm -rf ./tmp

permission:
	chmod 774 *.sh

test: permission clear
	find . -name "*_test.sh" -exec "{}" \;

cloc:
	cloc --exclude-ext=json .

.PHONY: test permission clean cloc clean-cache run
