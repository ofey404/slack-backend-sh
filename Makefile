permission:
	chmod 774 *.sh

test: permission
	find . -name "*_test.sh" -exec "{}" \;

.PHONY: test permission
