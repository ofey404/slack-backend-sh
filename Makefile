run:
	./main.sh

clean:
	rm -rf ./data

permission:
	chmod 774 *.sh

test: permission clear
	find . -name "*_test.sh" -exec "{}" \;

cloc:
	cloc --exclude-ext=json .

.PHONY: test permission clean cloc run
