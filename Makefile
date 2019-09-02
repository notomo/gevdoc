test:
	THEMIS_VIM=nvim THEMIS_ARGS="-e -s --headless" themis
	THEMIS_VIM=vim THEMIS_ARGS="-e -s" themis

start:
	./bin/gevdoc --exclude test/autoload/_test_data

.PHONY: test
