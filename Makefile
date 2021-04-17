clean:
	rm -rf ./tmp
	rm -rf ./data

permission:
	chmod 774 *.sh

test: permission clear
	find . -name "*_test.sh" -exec "{}" \;

cloc:
	cloc --exclude-ext=json .

.PHONY: test permission clear cloc
