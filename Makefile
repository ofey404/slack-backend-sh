clean:
	rm -rf ./tmp

permission:
	chmod 774 *.sh

test: permission clear
	find . -name "*_test.sh" -exec "{}" \;

.PHONY: test permission clear
